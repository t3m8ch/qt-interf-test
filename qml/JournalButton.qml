import QtQuick
import QtQuick.Controls

Button {
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
