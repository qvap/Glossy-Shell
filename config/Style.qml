import Quickshell.Io

JsonObject {
    property int rounding: 15 // Shell-wise rounding
    property int screen_rounding: 15 // Rounding for corners of the screen
    property int bar_chunkiness: 60// Im not native in english and this property is named like that just for fun
    property int bar_group_margin: 4 // Margin for bar groups
    property bool show_date_in_clock_widget: true
    property real panel_glow_width: 50.0
    property bool floating_bar: true

    component EasingCurves: JsonObject {
        property list<real> bubblyWidth: [0.3, 0, 0.8, 0.15, 1, 1]
        property list<real> bubblyHeight: [0.3, 0, 0.8, 0.15, 1, 1]
    }
}