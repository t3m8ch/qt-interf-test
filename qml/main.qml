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

    function valueInRange(value, minValue, maxValue) {
        return value >= minValue && value <= maxValue;
    }

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
            minValue: 0
            maxValue: 100
            normalMinValue: 10
            normalMaxValue: 90
        }

        Gauge {
            title: "Температура"
            units: "°C"
            value: 20
            minValue: 0
            maxValue: 40
            normalMinValue: 10
            normalMaxValue: 30
            displayMinValue: -50
            displayMaxValue: 50
        }

        Gauge {
            title: "Давление"
            units: "мм рт ст"
            value: 760
            minValue: 0
            maxValue: 1000
            normalMinValue: 740
            normalMaxValue: 770
            displayMinValue: 600
            displayMaxValue: 800
        }

        MetadataCard {
            label: "25.04.2025"
        }

        MetadataCard {
            label: "09:01:00"
        }

        MetadataCard {
            label: "Санкт-Петербург"
        }
    }
}
