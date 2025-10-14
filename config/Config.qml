pragma Singleton

import Quickshell
import Quickshell.Io

/* manages load/save for configs */

Singleton {
    id: root

    property alias style: adapter.style

    FileView {
        path: "config.json"

        watchChanges: true
        onFileChanged: reload()

        onAdapterUpdated: writeAdapter()

        JsonAdapter {
            id: adapter
            property Style style: Style {}
        }
    }
}