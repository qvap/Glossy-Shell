import QtQuick
import Quickshell
import Quickshell.Io

JsonObject {
    property EasingCurves curves: EasingCurves {}
    property Durations durations: Durations {}

    component EasingCurves: JsonObject {
        property list<real> bubblyWidth: [0.23, 1.76, 0.05, 1.00, 1, 1]
        property list<real> bubblyHeight: [0.43, 1.72, 0.35, 0.96, 1, 1]
        property list<real> bubblyMove: [0.22, 1.84, 0.24, 0.93, 1, 1]
        property list<real> standard: [0.2, 0, 0, 1, 1, 1]
        property list<real> standartAccel: [0.3, 0, 1, 1, 1, 1]
        property list<real> standartDecel: [0, 0, 0, 1, 1, 1]
        property list<real> emphasized: [0.05, 0, 2 / 15, 0.06, 1 / 6, 0.4, 5 / 24, 0.82, 0.25, 1, 1, 1]
        property list<real> emphasizedAccel: [0.3, 0, 0.8, 0.15, 1, 1]
        property list<real> emphasizedDecel: [0.05, 0.7, 0.1, 1, 1, 1]
        property list<real> expressiveFastSpatial: [0.38, 1.21, 0.22, 1, 1, 1]
        property list<real> expressiveDefaultSpatial: [0.38, 1.21, 0.22, 1, 1, 1]
        property list<real> expressiveEffects: [0.34, 0.8, 0.34, 1, 1, 1]
    }

    component Durations: JsonObject {
        property int durationVeryShort: 100
        property int durationShort: 200
        property int durationMedium: 400
        property int durationLong: 600
        property int durationVeryLong: 900
    }
}