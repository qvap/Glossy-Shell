import Quickshell
import Quickshell.Wayland

/* base transparent window for widgets duh */

PanelWindow {
    required property string name

    WlrLayershell.namespace: `glossy-${name}`
    color: "transparent"
}
