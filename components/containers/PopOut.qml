import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.components
import qs.config

/* popout tooltip rendered inside MainWindow with its own Region */
// ENTIRELY VIBE_CODED // SUBJECT TO REVIEW

Item {
    id: root

    property bool shown: false
    property real targetX: 0
    property real targetY: 0
    property bool interactive: false
    property string anchorMode: "top" // "top" = above target, "side" = right of target
    property real sideAltX: 0 // fallback X when side popout doesn't fit on the right
    default property alias contentData: contentContainer.data

    signal entered
    signal exited

    // animated center position — this is what moves smoothly
    property real _animCenterX: 0
    property real _animCenterY: 0
    property real _animAltX: 0

    // vertical offset for slide-in animation
    property real _yOffset: 0

    // raw desired position before clamping
    property bool _sideFlipped: anchorMode === "side" && parent && (_animCenterX + width > parent.width)
    property real _rawX: anchorMode === "side" ? (_sideFlipped ? _animAltX - width : _animCenterX) : _animCenterX - width / 2
    property real _rawY: anchorMode === "side" ? _animCenterY - height / 2 + _yOffset : _animCenterY - height - Config.style.spacing.small + _yOffset

    // clamp to parent boundaries
    x: parent ? Math.max(0, Math.min(_rawX, parent.width - width)) : _rawX
    y: parent ? Math.max(0, Math.min(_rawY, parent.height - height)) : _rawY

    visible: opacity > 0
    opacity: 0

    layer.enabled: true
    layer.effect: DropShadow {}

    Behavior on _animCenterX {
        enabled: root.opacity > 0
        NumberAnimation {
            duration: Config.animation.duration.normal
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Config.animation.curves.standard
        }
    }

    Behavior on _animCenterY {
        enabled: root.opacity > 0
        NumberAnimation {
            duration: Config.animation.duration.normal
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Config.animation.curves.standard
        }
    }

    onTargetXChanged: _animCenterX = targetX
    onTargetYChanged: _animCenterY = targetY
    onSideAltXChanged: _animAltX = sideAltX

    onShownChanged: {
        if (shown) {
            // snap position instantly before animating in
            _animCenterX = targetX;
            _animCenterY = targetY;
            _animAltX = sideAltX;
            showAnimation.start();
        } else {
            hideAnimation.start();
        }
    }

    ParallelAnimation {
        id: showAnimation
        running: false

        onStarted: {
            if (hideAnimation.running)
                hideAnimation.stop();
        }

        NumberAnimation {
            target: root
            property: "opacity"
            from: 0.0
            to: 1.0
            duration: Config.animation.duration.small
            easing.type: Easing.OutQuart
        }

        NumberAnimation {
            target: root
            property: "_yOffset"
            from: 8
            to: 0
            duration: Config.animation.duration.normal
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Config.animation.curves.emphasizedDecel
        }
    }

    ParallelAnimation {
        id: hideAnimation
        running: false

        onStarted: {
            if (showAnimation.running)
                showAnimation.stop();
        }

        NumberAnimation {
            target: root
            property: "opacity"
            to: 0.0
            duration: Config.animation.duration.small
            easing.type: Easing.InQuart
        }

        NumberAnimation {
            target: root
            property: "_yOffset"
            to: 8
            duration: Config.animation.duration.small
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Config.animation.curves.standartAccel
        }
    }

    StyledPanelRectangle {
        id: background
        anchors.fill: parent
        radius: Config.style.rounding.small
    }

    HoverHandler {
        enabled: root.interactive
        onHoveredChanged: {
            if (hovered)
                root.entered();
            else
                root.exited();
        }
    }

    ColumnLayout {
        id: contentContainer
        anchors {
            fill: parent
            margins: Config.style.padding.small
        }
        spacing: Config.style.spacing.verySmall
    }
}
