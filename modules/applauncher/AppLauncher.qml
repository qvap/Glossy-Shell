pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs
import qs.components

Item {
    id: root
    required property ShellScreen screen

    // Content dimensions
    implicitWidth: background.implicitWidth
    implicitHeight: background.implicitHeight

    // Background container
    StyledRectangle {
        id: background
        
        anchors.fill: parent
        implicitWidth: 500
        implicitHeight: columnLayout.implicitHeight + columnLayout.anchors.margins * 2
        
        // Content layout
        Column {
            id: columnLayout
            
            anchors {
                fill: parent
                margins: 10
            }
            
            spacing: 10
            
            // Application list placeholder
            Item {
                width: parent.width
                height: 300
                
                StyledText {
                    anchors.centerIn: parent
                    text: qsTr("Application list will be here")
                    color: "#666666"
                }
            }
            
            // Search field at the bottom
            StyledTextField {
                id: search
                
                width: parent.width
                implicitHeight: 50
                
                placeholderText: qsTr("Search...")
                placeholderTextColor: "#888888"
                
                Component.onCompleted: forceActiveFocus()
                
                // Handle Escape key to close launcher
                Keys.onEscapePressed: Global.launcherOpen = false
            }
        }
    }
}