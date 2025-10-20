pragma Singleton

import Quickshell
import Quickshell.Io

/* manages load/save for configs */

Singleton {
    id: root

    property alias style: adapter.style
    property alias animation: adapter.animation
    property alias workspace: adapter.workspace

    FileView {
        path: "config.json"

        watchChanges: true
        onFileChanged: reload()

        onAdapterUpdated: writeAdapter()

        JsonAdapter {
            id: adapter
            property StyleConf style: StyleConf {}
            property AnimationConf animation: AnimationConf {}
            property WorkspaceConf workspace: WorkspaceConf {}
        }
    }
}