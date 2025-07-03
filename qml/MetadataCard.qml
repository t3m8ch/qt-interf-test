import QtQuick
import QtQuick.Layouts

Rectangle {
    property string label: ""

    property color borderColor: "#d4d4d4"
    property color backgroundColor: "#29363C"

    Layout.fillWidth: true
    Layout.preferredHeight: 50
    color: backgroundColor
    border.width: 1
    border.color: borderColor

    Text {
        anchors.centerIn: parent
        text: label
        color: label === "" ? borderColor : "#FFFFFF"
        font.pixelSize: 30
        font.family: "Roboto"
    }
}
