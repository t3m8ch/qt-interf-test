import QtQuick

Rectangle {
    property string label: ""

    property color borderColor: "#d4d4d4"
    property color backgroundColor: "#29363C"

    color: backgroundColor
    border.width: 1
    border.color: borderColor

    Text {
        anchors.centerIn: parent
        text: label === "" ? "---" : label
        color: label === "" ? "#647d89" : "#FFFFFF"
        font.pixelSize: 30
        font.family: "Roboto"
    }
}
