import QtQuick 6.4
import QtQuick.Controls 6.4

ApplicationWindow {
    id: mainwindow

    flags: Qt.Window | Qt.FramelessWindowHint
    width: 900
    height: 450
    visible: true
    color: "#394955"
    title: "QT-Interf"

    FontLoader {
        id: roboto
        source: "qrc:/qt/qml/QtInterfTest/fonts/Roboto.ttf"
    }

    TitleBar {
        mainwindow: mainwindow
    }
}
