import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQml.Models 2.15

Rectangle {
    property color backgroundColor: 'gray'
    property color borderColor: 'gray'
    color: backgroundColor
    property alias columns: repeater.model
    property var sizes: []
    property bool isReady: false
    height: 50
    function get(index) {
        if (index >= repeater.count)
            console.log("error")
        return repeater.itemAt(index)
    }

    SplitView {
        anchors.fill: parent
        Repeater {
            id: repeater
            Label {
                text: modelData.title
                SplitView.fillWidth: modelData.fillWidth
                SplitView.preferredWidth: modelData.size !== '*'
                                          ? modelData.size : 20
                verticalAlignment: "AlignVCenter"
                clip: true
                elide: "ElideRight"

                leftPadding: 4
            }

            onItemAdded: if (repeater.count === columns.length) isReady = true
        }
    }

    Rectangle {
        anchors {
            left: parent.left
            bottom: parent.bottom
            right: parent.right
        }
        height: 1
        color: borderColor
    }
}
