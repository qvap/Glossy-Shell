import Quickshell.Io

/* organizes stuff for usage */

JsonObject {
    property EasingCurves curves: EasingCurves {}
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

    component EasingCurves: JsonObject {
        property list<real> bubblyWidth: [0.3, 0, 0.8, 0.15, 1, 1]
        property list<real> bubblyHeight: [0.3, 0, 0.8, 0.15, 1, 1]
    }
    component Fonts: JsonObject {
        property string sans: "Noto Sans"
        property string icons: "Material Symbols Rounded"
    }
}
