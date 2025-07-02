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
        id: gaugeContainer
        anchors.centerIn: parent
        width: Math.min(parent.width, parent.height) * 0.6
        height: width

        readonly property real gaugeRadius: width * 0.6 - 10

        Shape {
            id: backgroundCircle
            anchors.fill: parent

            ShapePath {
                strokeWidth: 8
                strokeColor: "#5a6a77"
                fillColor: "transparent"
                capStyle: ShapePath.RoundCap

                PathAngleArc {
                    centerX: gaugeContainer.width / 2
                    centerY: gaugeContainer.height / 2
                    radiusX: gaugeContainer.gaugeRadius
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
                    centerX: gaugeContainer.width / 2
                    centerY: gaugeContainer.height / 2
                    radiusX: gaugeContainer.gaugeRadius
                    radiusY: radiusX
                    startAngle: -90
                    sweepAngle: 360 * (gaugeRoot.value / gaugeRoot.maxValue)
                }
            }
        }

        Text {
            anchors.centerIn: parent
            text: Math.round(gaugeRoot.value)
            color: "white"
            font.pixelSize: gaugeContainer.width * 0.3
            font.family: "Roboto"
            font.weight: Font.Bold
        }
    }
}
