import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    id: cell
    property alias text: label.text
    property int w: handler.x + handler.width
    width: handler.x + handler.width + 4

    onWChanged: console.log(w)
    property int initialWidth: 0
    onInitialWidthChanged: if (initialWidth !== 0) cell.width = initialWidth - handler.width
    Component.onCompleted: {
        handler.x = cell.width - handler.width
    }

    Label {
        id: label
        text: modelData.title

        anchors.fill: parent
        anchors.rightMargin: handler.width
        verticalAlignment: "AlignVCenter"
        clip: true
        elide: "ElideRight"

//        leftPadding: 4

        background: Rectangle {
            color: modelData.color
        }
    }

    DataGridHeaderResizeHandler {
        id: handler
        color: 'white'

        width: 4
        height: parent.height

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.SplitHCursor
            drag.target: handler
            drag.axis: Drag.XAxis
            drag.minimumX: 0
        }
    }
}
