pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

/* vibe-coded service cuz i hate clis */

Singleton {
    id: root

    property string wallpaperPath: Quickshell.env("HOME") + "/Pictures/Wallpapers"
    property var wallpapers: []
    property bool loading: false

    Process {
        id: process
        running: false

        stdout: StdioCollector {
            onStreamFinished: {
                const output = text.trim();
                if (output.length > 0) {
                    const files = output.split('\n').filter(file => {
                        const lower = file.toLowerCase();
                        return lower.endsWith('.png') || lower.endsWith('.jpg') || lower.endsWith('.jpeg');
                    });
                    root.wallpapers = files;
                    console.log(`Loaded ${files.length} wallpapers from ${root.wallpaperPath}`);
                } else {
                    root.wallpapers = [];
                    console.log(`No wallpapers found in ${root.wallpaperPath}`);
                }
                root.loading = false;
            }
        }

        onExited: (exitCode, exitStatus) => {
            if (exitCode !== 0) {
                console.error(`Failed to load wallpapers from ${root.wallpaperPath}`);
                root.wallpapers = [];
                root.loading = false;
            }
        }
    }

    function loadWallpapers() {
        if (root.loading) {
            console.log("Already loading wallpapers...");
            return;
        }

        root.loading = true;
        root.wallpapers = [];
        console.log(`Loading wallpapers from: ${root.wallpaperPath}`);

        process.command = ["sh", "-c", `find -L "${root.wallpaperPath}" -maxdepth 1 -type f \\( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \\) 2>/dev/null`];
        process.running = true;
    }

    function setWallpaperPath(path) {
        root.wallpaperPath = path;
        loadWallpapers();
    }

    Component.onCompleted: {
        loadWallpapers();
    }
}
