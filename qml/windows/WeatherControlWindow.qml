import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtInterfTest.Components

ApplicationWindow {
    id: mainwindow

    flags: Qt.Window | Qt.FramelessWindowHint
    width: 600
    height: 850
    visible: true
    color: "#394955"
    title: "Управление метеоданными"

    function showExitDialog() {
        exitDialog.open();
    }

    FontLoader {
        id: roboto
        source: "qrc:/qt/qml/QtInterfTest/Resources/fonts/Roboto.ttf"
    }

    ResizeArea {
        id: resizeArea
        mainwindow: mainwindow
    }

    TitleBar {
        id: titleBar
        title: "Управление метеоданными"
        mainwindow: mainwindow
    }

    ExitDialog {
        id: exitDialog
    }

    ColumnLayout {
        anchors.top: titleBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 20
        spacing: 20

        BorderWithBreak {
            text: "Источник данных"
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        BorderWithBreak {
            text: "Параметры"
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        BorderWithBreak {
            text: "Дата/Время"
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        BorderWithBreak {
            text: "Местоположение"
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
