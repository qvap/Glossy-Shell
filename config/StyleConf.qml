import Quickshell.Io

/* organizes stuff for usage */

JsonObject {
    property Rounding rounding: Rounding {}
    property BarStyle barstyle: BarStyle {}
    property Gradients gradients: Gradients {}
    property Fonts fonts: Fonts {}
    property Spacing spacing: Spacing {}
    property Padding padding: Padding {}
    property ColorFactors colorFactors: ColorFactors {}

    component Rounding: JsonObject {
        property real scale: 1.2
        property int small: 12 * scale
        property int normal: 17 * scale
        property int large: 25 * scale
        property int full: 1000 * scale
    }

    component BarStyle: JsonObject {
        property int bar_chunkiness: 58 // Im not native in english and this property is named like that just for fun
        property int bar_group_margin: 5 // Margin for bar groups
        property bool show_date_in_clock_widget: true
        property bool floating_bar: true
    }

    component Gradients: JsonObject {
        property real panel_glow_width: 50.0 // Width of the glow effect on panels
    }

    component Fonts: JsonObject {
        property real scale: 1.2
        property real iconScale: 1.4
        property string sans: "Noto Sans"
        property string icons: "Material Symbols Rounded"
        property int verySmallSize: 11 * scale
        property int smallSize: 12 * scale
        property int standartSize: 13 * scale
        property int largeSize: 15 * scale
        property int veryLargeSize: 18 * scale
    }

    component Spacing: JsonObject {
        property real scale: 1.2
        property int verySmall: 7 * scale
        property int small: 10 * scale
        property int standart: 12 * scale
        property int large: 15 * scale
        property int veryLarge: 20 * scale
    }

    component Padding: JsonObject {
        property real scale: 1.2
        property int verySmall: 5 * scale
        property int small: 7 * scale
        property int standart: 10 * scale
        property int large: 12 * scale
        property int veryLarge: 15 * scale
    }

    component ColorFactors: JsonObject {
        property real lightGradientTop: 1.8
        property real darkGradientBottom: 7.0
        property real borderDark: 4.0
        property real glowLight: 1.5
        property real highlightLight: 1.6
        property real borderLight: 2.0
    }
}
