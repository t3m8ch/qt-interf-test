import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes

Rectangle {
    id: gaugeRoot
    Layout.fillWidth: true
    Layout.fillHeight: true
    color: backgroundColor

    /*!
        \brief Заголовок индикатора, отображаемый сверху компонента.
    */
    property string title: ""

    /*!
        \brief Единицы измерения для отображения рядом с заголовком.
    */
    property string units: ""

    /*!
        \brief Текущее значение, отображаемое на индикаторе.
    */
    property real value: 0

    /*!
        \brief Доступны ли данные. Если да, отобразить значение по правилам ниже,
        иначе отобразить три штриха.
    */
    property bool loaded: true

    /*!
        \brief Отрезок [minValue, maxValue] определяет, при каком диапазоне значений
        круговая диаграмма будет принимать значения от 0% до 100%.
    */
    property real minValue: 0
    property real maxValue: 100

    /*!
        \brief При value принадлежащему диапазону [normalMinValue, normalMaxValue]
        круговая диаграмма будет иметь зелёный цвет, в противном случае - жёлтый.
    */
    property real normalMinValue: minValue
    property real normalMaxValue: maxValue

    /*!
        \brief При value принадлежащему диапазону [displayMinValue, displayMaxValue]
        будет отображаться реальное значение белым цветом, в противном случае
        - три штриха жёлтым цветом.
    */
    property real displayMinValue: minValue
    property real displayMaxValue: maxValue

    /*!
        \brief Цвет фона компонента индикатора.
    */
    property color backgroundColor: "#394955"

    /*!
        \brief Цвет границы и текста заголовка.
    */
    property color borderColor: "#d4d4d4"

    /*!
        \brief Цвет фонового кольца индикатора.
    */
    property color backgroundStrokeColor: "#647D89"

    /*!
        \brief Цвет активного кольца индикатора в [normalMinValue, normalMaxValue].
    */
    property color normalValueColor: "#64ff89"

    /*!
        \brief Цвет активного кольца индикатора при значении вне [normalMinValue, normalMaxValue].
    */
    property color warningValueColor: "#fff500"

    function valueTextColor(value) {
        if (!loaded) {
            return backgroundStrokeColor;
        }

        return valueInRange(value, gaugeRoot.displayMinValue, gaugeRoot.displayMaxValue) ? "white" : warningValueColor;
    }

    function gaugeAngle(value) {
        if (!loaded)
            return 0;

        if (value < gaugeRoot.minValue)
            return 0;

        if (value > gaugeRoot.maxValue)
            return 360;

        return 360 * ((gaugeRoot.value - gaugeRoot.minValue) / (gaugeRoot.maxValue - gaugeRoot.minValue));
    }

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
                strokeColor: valueInRange(gaugeRoot.value, gaugeRoot.normalMinValue, gaugeRoot.normalMaxValue) ? normalValueColor : warningValueColor
                fillColor: "transparent"
                capStyle: ShapePath.RoundCap

                PathAngleArc {
                    centerX: gaugeContainer.width / 2
                    centerY: gaugeContainer.height / 2
                    radiusX: gaugeContainer.gaugeRadius
                    radiusY: radiusX
                    startAngle: -90
                    sweepAngle: gaugeAngle(gaugeRoot.value)
                }
            }
        }

        Text {
            anchors.centerIn: parent
            text: loaded && valueInRange(gaugeRoot.value, gaugeRoot.displayMinValue, gaugeRoot.displayMaxValue) ? Math.round(gaugeRoot.value) : "---"
            color: valueTextColor(gaugeRoot.value)
            font.pixelSize: gaugeContainer.width * 0.3
            font.family: "Roboto"
            font.weight: loaded ? Font.Bold : Font.Normal
        }
    }
}
