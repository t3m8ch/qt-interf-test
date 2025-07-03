import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Button {
    Layout.alignment: Qt.AlignHCenter
    Layout.preferredWidth: (gaugeGrid.width - 40) / 3
    Layout.preferredHeight: 40
    text: "Журнал"

    background: Rectangle {
        color: "#65808B"
    }

    contentItem: Text {
        text: parent.text
        color: "#d4d4d4"
        font.pixelSize: 30
        font.family: roboto.name
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    onClicked: () => {
        console.info("ABOBA");
    }
}
