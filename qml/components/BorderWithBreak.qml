import QtQuick

Rectangle {
    property string text
    property color backgroundColor: "#394955"
    property color borderColor: "#d4d4d4"

    Rectangle {
        id: borderRect
        anchors.fill: parent
        color: "transparent"
        border.color: borderColor
        border.width: 1

        Rectangle {
            id: borderBreak
            height: titleText.height
            width: titleText.width + 20
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: -height / 2
            color: backgroundColor
        }
    }

    Text {
        id: titleText
        text: parent.text
        color: borderColor
        font.pixelSize: 22
        font.family: "Roboto"
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: -height / 2
        z: 2
    }
}
