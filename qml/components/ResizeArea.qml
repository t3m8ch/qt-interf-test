import QtQuick

MouseArea {
    anchors.fill: parent
    hoverEnabled: true

    property int edgeOffset: 5
    property Window mainwindow

    onPressed: {
        if (mouseX < edgeOffset) {
            if (mouseY < edgeOffset) {
                mainwindow.startSystemResize(Qt.TopEdge | Qt.LeftEdge);
            } else if (mouseY > height - edgeOffset) {
                mainwindow.startSystemResize(Qt.BottomEdge | Qt.LeftEdge);
            } else {
                mainwindow.startSystemResize(Qt.LeftEdge);
            }
        } else if (mouseX > width - edgeOffset) {
            if (mouseY < edgeOffset) {
                mainwindow.startSystemResize(Qt.TopEdge | Qt.RightEdge);
            } else if (mouseY > height - edgeOffset) {
                mainwindow.startSystemResize(Qt.BottomEdge | Qt.RightEdge);
            } else {
                mainwindow.startSystemResize(Qt.RightEdge);
            }
        } else if (mouseY < edgeOffset) {
            mainwindow.startSystemResize(Qt.TopEdge);
        } else if (mouseY > height - edgeOffset) {
            mainwindow.startSystemResize(Qt.BottomEdge);
        }
    }

    onPositionChanged: {
        if (mouseX < edgeOffset || mouseX > width - edgeOffset) {
            cursorShape = Qt.SizeHorCursor;
        } else if (mouseY < edgeOffset || mouseY > height - edgeOffset) {
            cursorShape = Qt.SizeVerCursor;
        } else {
            cursorShape = Qt.ArrowCursor;
        }
    }
}
