import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    id: handler
    property color color: 'gray'

    implicitWidth: 4
    implicitHeight: 4

    Rectangle {
        anchors {
            top: parent.top
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
        width: 1
        color: SplitHandle.pressed ? Qt.lighter(handler.color, 1.3)
                                   : (SplitHandle.hovered ? Qt.darker(handler.color, 1.1) : handler.color)
    }
}
