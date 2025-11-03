pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root

    property PwNode sink: Pipewire.defaultAudioSink
    property PwNode source: Pipewire.defaultAudioSource

    property bool defaultSinkMuted: !!sink?.audio?.muted
    property real defaultSinkVolume: sink?.audio?.volume ?? 0

    PwObjectTracker {
        objects: [sink, source]
    }
}
