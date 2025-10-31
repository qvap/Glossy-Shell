pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

Singleton {
    id: root

    property list<string> layoutCodes: []
    property var cachedLayoutCodes: ({})
    property string currentLayoutName: ""
    property string currentLayoutCode: ""

    property var baseLayoutFilePath: "/usr/share/X11/xkb/rules/base.lst"
    property bool needsLayoutRefresh: true

    onCurrentLayoutNameChanged: root.updateLayoutCode()
    function updateLayoutCode() {
        if (cachedLayoutCodes.hasOwnProperty(currentLayoutName)) {
            root.currentLayoutCode = cachedLayoutCodes[currentLayoutName];
        } else {
            getLayoutProc.running = true;
        }
    }

    Process {
        id: getLayoutProc
        command: ["cat", root.baseLayoutFilePath]

        stdout: StdioCollector {
            id: layoutCollector

            onStreamFinished: {
                const lines = layoutCollector.text.split("\n");
                const targetDescription = root.currentLayoutName;
                const foundLine = lines.find(line => {
                    if (!line.trim() || line.trim().startsWith('!'))
                        return false;

                    const match = line.match(/^\s*(\S+)\s+(.+)$/);
                    if (match && match[2] === targetDescription) {
                        root.cachedLayoutCodes[match[2]] = match[1];
                        root.currentLayoutCode = match[1];
                        return true;
                    }
                });
            }
        }
    }

    Process {
        id: fetchLayoutProc
        running: true
        command: ["hyprctl", "-j", "devices"]

        stdout: StdioCollector {
            id: devicesCollector
            onStreamFinished: {
                const parsedOutput = JSON.parse(devicesCollector.text);
                const hyprlandKeyboard = parsedOutput["keyboards"].find(kb => kb.main === true);
                root.layoutCodes = hyprlandKeyboard["layout"].split(",");
                root.currentLayoutName = hyprlandKeyboard["active_keymap"];
            }
        }
    }

    Connections {
        target: Hyprland
        function onRawEvent(event) {
            if (event.name === "activelayout") {
                if (root.needsLayoutRefresh) {
                    root.needsLayoutRefresh = false;
                    fetchLayoutProc.running = true;
                }

                if (root.layoutCodes.length <= 1)
                    return;

                const dataString = event.data;
                root.currentLayoutName = dataString.split(",")[1];

                // Config.options.osk.layout = root.currentLayoutName;
            } else if (event.name == "configreloaded") {
                root.needsLayoutRefresh = true;
            }
        }
    }
}
