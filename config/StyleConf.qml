import Quickshell.Io

/* organizes stuff for usage */

JsonObject {
    property Rounding rounding: Rounding {}
    property BarStyle barstyle: BarStyle {}
    property Gradients gradients: Gradients {}
    property Fonts fonts: Fonts {}

    component Rounding: JsonObject {
        property int rounding: 16 // Shell-wise rounding
        property int screen_rounding: 15 // Rounding for corners of the screen
    }

    component BarStyle: JsonObject {
        property int bar_chunkiness: 60 // Im not native in english and this property is named like that just for fun
        property int bar_group_margin: 5 // Margin for bar groups
        property bool show_date_in_clock_widget: true
        property bool floating_bar: true
    }

    component Gradients: JsonObject {
        property real panel_glow_width: 50.0 // Width of the glow effect on panels
    }

    component Fonts: JsonObject {
        property string sans: "Noto Sans"
        property string icons: "Material Symbols Rounded"
        property real verySmallSize: 6.88
        property real smallSize: 11.12
        property real standartSize: 18.0
        property real largeSize: 29.0
        property real veryLargeSize: 47.0
    }
}
