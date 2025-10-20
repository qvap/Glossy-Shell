import QtQuick
import Quickshell
import Quickshell.Io

JsonObject {
    property Workspace workspace: Workspace {}

    component Workspace: JsonObject {
        property int count: 5
    }
}