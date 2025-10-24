pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property alias primary: colors.primary

    FileView {
        path: Quickshell.shellDir + "/userconfig/colors.json"

        watchChanges: true
        onFileChanged: reload()

        onAdapterUpdated: writeAdapter()

        JsonAdapter {
            id: adapter
            property JsonObject colors: JsonObject {
                id: colors
                property string primary: "#00e836"
            }
        }
    }
}
