import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtInterfTest.Components

ApplicationWindow {
    id: mainwindow

    flags: Qt.Window | Qt.FramelessWindowHint
    width: 900
    height: 450
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
}
