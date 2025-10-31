import QtQuick
import QtQuick.Layouts
import qs.config

StyledPanelRectangle {
    id: searchBackground

    property alias icon: searchIcon.text
    property alias searchField: search

    signal textEdited(string text)

    implicitHeight: 56
    radius: Config.style.rounding.full

    RowLayout {
        anchors {
            fill: parent
            margins: 16
        }

        MaterialIcon {
            id: searchIcon
            text: "search"
            font.pixelSize: 24
            color: "white"
            Layout.fillHeight: true
        }

        StyledTextField {
            id: search

            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignLeft

            placeholderText: "Type '>' to change wallpaper..."

            onTextEdited: {
                searchBackground.textEdited(text);
            }
        }
    }
}
