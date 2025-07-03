import QtQuick 6.4
import Qt5Compat.GraphicalEffects

Rectangle {
    property Window mainwindow

    width: parent.width
    height: 40
    color: "#2A3740"

    Text {
        text: "Метеоданные"
        color: "#d4d4d4"
        font.family: "Roboto"
        font.pixelSize: 22
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 20
    }

    Row {
        id: windowControls
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: 5
        anchors.rightMargin: 5

        Rectangle {
            id: minimizeButton
            width: 50
            height: 30
            anchors.verticalCenter: parent.verticalCenter
            color: minimizeArea.containsMouse ? "#4A5A66" : "#5D737F"

            Image {
                id: minimizeIcon
                source: "qrc:/qt/qml/QtInterfTest/icons/subtract-line.svg"
                width: 24
                height: 24
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 6
            }

            ColorOverlay {
                anchors.fill: minimizeIcon
                source: minimizeIcon
                color: "#ffffff"
            }

            MouseArea {
                id: minimizeArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: function () {
                    mainwindow.showMinimized();
                }
            }
        }

        Rectangle {
            id: maximizeButton
            width: 50
            height: 30
            anchors.verticalCenter: parent.verticalCenter
            color: maximizeArea.containsMouse ? "#4A5A66" : "#5D737F"

            Image {
                id: maximizeIcon
                source: "qrc:/qt/qml/QtInterfTest/icons/stop-line.svg"
                width: 24
                height: 24
                anchors.centerIn: parent
            }

            ColorOverlay {
                anchors.fill: maximizeIcon
                source: maximizeIcon
                color: "#ffffff"
            }

            MouseArea {
                id: maximizeArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: function () {
                    if (mainwindow.visibility === Window.Maximized) {
                        mainwindow.showNormal();
                    } else {
                        mainwindow.showMaximized();
                    }
                }
            }
        }

        Rectangle {
            id: closeButton
            width: 50
            height: 30
            anchors.verticalCenter: parent.verticalCenter
            color: closeArea.containsMouse ? "#E81123" : "#5D737F"

            Image {
                id: closeIcon
                source: "qrc:/qt/qml/QtInterfTest/icons/close-line.svg"
                width: 24
                height: 24
                anchors.centerIn: parent
            }

            ColorOverlay {
                anchors.fill: closeIcon
                source: closeIcon
                color: "#ffffff"
            }

            MouseArea {
                id: closeArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: () => showExitDialog()
            }
        }
    }

    DragHandler {
        target: null
        onActiveChanged: if (active) {
            mainwindow.startSystemMove();
        }
    }
}
