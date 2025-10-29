import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.components
import qs.config
import qs

Item {
    id: root

    required property string modelData
    required property int index
    required property int currentIndex
    required property int itemWidth

    width: itemWidth
    implicitHeight: 200

    signal itemClicked(int itemIndex)

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.itemClicked(index);
        }
        onDoubleClicked: {
            root.setWallpaper();
            Global.launcherOpen = false;
        }
    }

    ClippingRectangle {
        anchors {
            centerIn: parent
        }
        width: wallpaper.width
        height: wallpaper.height
        radius: Config.style.rounding.small
        Image {
            id: wallpaper
            anchors {
                centerIn: parent
            }
            source: Qt.resolvedUrl(root.modelData)
            fillMode: Image.PreserveAspectCrop
            smooth: true
            asynchronous: true
            sourceSize.width: 200
        }

        Rectangle { // make text more readable
            anchors {
                fill: parent
            }

            gradient: Gradient {
                GradientStop {
                    position: 0.6
                    color: Qt.rgba(0, 0, 0, 0)
                }
                GradientStop {
                    position: 1.0
                    color: Qt.rgba(0, 0, 0, 0.8)
                }
            }
        }

        StyledText {
            width: parent.width - Config.style.padding.standart * 2
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
            text: root.modelData.split('/').pop()
            font.pixelSize: 14
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignHCenter
            color: "white"
        }

        Rectangle {
            anchors {
                fill: parent
            }
            color: "transparent"
            radius: Config.style.rounding.small
            border {
                color: Qt.lighter(Colors.primary, 2.0)
                width: root.ListView.isCurrentItem ? 1 : 0

                Behavior on width {
                    BaseAnimation {}
                }
            }
        }

        transform: Rotation {
            origin {
                x: root.width
                y: 0
            }
            axis {
                x: 0
                y: 1
                z: 0
            }
            angle: (root.index === root.currentIndex) ? 0 : ((root.index > root.currentIndex) ? -75 : 75)

            Behavior on angle {
                BaseAnimation {}
            }
        }
    }
    Behavior on width {
        BaseAnimation {}
    }



    function setWallpaper() {
        Quickshell.execDetached(["matugen", "image", root.modelData]);
    }
}
