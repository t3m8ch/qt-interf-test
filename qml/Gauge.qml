import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes

Rectangle {
    id: gaugeRoot
    Layout.fillWidth: true
    Layout.fillHeight: true
    color: backgroundColor

    property string title: ""
    property string units: ""
    property real value: 0
    property real maxValue: 100

    property color backgroundColor: "#394955"
    property color borderColor: "#d4d4d4"
    property color backgroundStrokeColor: "#5a6a77"
    property color valueStrokeColor: "#4CAF50"

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
        text: parent.title + ", " + parent.units
        color: borderColor
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
                strokeColor: backgroundStrokeColor
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
                strokeColor: valueStrokeColor
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
