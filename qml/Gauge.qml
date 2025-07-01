import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes

Rectangle {
    id: gaugeRoot
    Layout.fillWidth: true
    Layout.fillHeight: true
    color: "#394955"

    property string title: ""
    property string units: ""
    property real value: 0
    property real maxValue: 100

    Rectangle {
        id: borderRect
        anchors.fill: parent
        color: "transparent"
        border.color: "#d4d4d4"
        border.width: 1

        Rectangle {
            id: borderBreak
            height: titleText.height
            width: titleText.width + 20
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: -height / 2
            color: "#394955"
        }
    }

    Text {
        id: titleText
        text: parent.title + ", " + parent.units
        color: "#d4d4d4"
        font.pixelSize: 22
        font.family: "Roboto"
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: -height / 2
        z: 2
    }

    Item {
        anchors.centerIn: parent
        width: Math.min(parent.width, parent.height) * 0.6
        height: width

        Shape {
            id: backgroundCircle
            anchors.fill: parent

            ShapePath {
                strokeWidth: 8
                strokeColor: "#5a6a77"
                fillColor: "transparent"
                capStyle: ShapePath.RoundCap

                PathAngleArc {
                    centerX: backgroundCircle.width / 2
                    centerY: backgroundCircle.width / 2
                    radiusX: parent.width / 2 * 0.6 - 10
                    radiusY: radiusX
                    startAngle: 0
                    sweepAngle: 360
                }
            }
        }

        Shape {
            anchors.fill: parent

            ShapePath {
                strokeWidth: 8
                strokeColor: "#4CAF50"
                fillColor: "transparent"
                capStyle: ShapePath.RoundCap

                PathAngleArc {
                    centerX: backgroundCircle.width / 2
                    centerY: backgroundCircle.width / 2
                    radiusX: parent.width / 2 * 0.6 - 10
                    radiusY: radiusX
                    startAngle: -90
                    sweepAngle: 360 * (gaugeRoot.value / gaugeRoot.maxValue)
                }
            }
        }

        Text {
            anchors.centerIn: parent
            text: Math.round(parent.parent.value)
            color: "white"
            font.pixelSize: parent.width * 0.3
            font.family: "Roboto"
            font.weight: 700
        }
    }
}
