import QtQuick
import QtQuick.Controls

Dialog {
    title: "Подтверждение"
    modal: true
    anchors.centerIn: parent
    width: 400

    contentItem: Text {
        text: "Подтвердите выход из приложения"
        font.pixelSize: 22
        font.family: "Roboto"
    }

    standardButtons: Dialog.Yes | Dialog.No

    onAccepted: {
        Qt.quit();
    }
}
