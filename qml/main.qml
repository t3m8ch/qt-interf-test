import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

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
        id: titleBar
        mainwindow: mainwindow
    }

    GridLayout {
        anchors.top: titleBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 20
        columns: 3
        columnSpacing: 20
        rowSpacing: 20

        Gauge {
            title: "Влажность"
            units: "%"
            value: 50
            maxValue: 100
        }

        Gauge {
            title: "Температура"
            units: "°C"
            value: 20
            maxValue: 40
        }

        Gauge {
            title: "Давление"
            units: "мм рт ст"
            value: 760
            maxValue: 800
        }
    }
}
