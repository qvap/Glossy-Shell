import QtQuick
import QtQuick.Effects
import qs.config

/* not cost-efficient shadow for any other shape */

MultiEffect {
    shadowEnabled: true
    shadowVerticalOffset: 5
    shadowOpacity: 0.8
    shadowColor: Qt.darker(Colors.primary, 4.0)
}