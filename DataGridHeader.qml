import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQml.Models 2.15

Rectangle {
    property color borderColor: 'gray'
    color: backgroundColor
    property alias columns: repeater.model
    property var sizes: []
    property bool isReady: false
    property alias horizontalLine: horizontalLineRect.visible
    property int endMargin: 0
    property int spacing: 4
    property bool fitColumn: true

    height: 50
    function get(index) {
//        if (index >= repeater.count)
//            console.log("error")
        return repeater.itemAt(index)
    }
    Item {
        anchors.fill: parent
        anchors.rightMargin: endMargin

        SplitView {
            id: splitView

            width: contentWidth
            state: fitColumn ? "fit" : "no_fit"
            states: [
                State {
                    name: "fit"
                    AnchorChanges {
                        target: splitView
                        anchors {
                            top: parent.top
                            left: parent.left
                            bottom: parent.bottom
                            right: parent.right
                        }
                    }
                },
                State {
                    name: "no_fit"
                    AnchorChanges {
                        target: splitView
                        anchors {
                            top: parent.top
                            left: parent.left
                            bottom: parent.bottom
                        }
                    }
                }
            ]
            handle: DataGridHeaderResizeHandler {
                color: borderColor
            }
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

                    background: Rectangle {
                        color: modelData.color
                    }
                }
                onItemAdded: if (repeater.count === columns.length) isReady = true
            }
        }
    }
//    Rectangle {
//        anchors {
//            left: splitView.left
//            bottom: splitView.bottom
//            right: splitView.right
//        }
//        height: 3
//        color: 'red'
//    }

    Rectangle {
        id: horizontalLineRect
        anchors {
            left: parent.left
            bottom: parent.bottom
            right: parent.right
        }
        height: 1
        color: borderColor
    }
}
