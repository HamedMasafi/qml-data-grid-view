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

    signal finished()
    onColumnsChanged: finished()

    height: 50
    function get(index) {
        return (fitColumn ? repeater : repeater2).itemAt(index)
    }
    property int actualWidth: fitColumn ? width : layout.width

    Item {
        anchors.fill: parent
        anchors.rightMargin: endMargin

        RowLayout {
            id: layout
            anchors {
                top: parent.top
                left: parent.left
                bottom: parent.bottom
            }
            visible: !fitColumn
            spacing: 4

            Repeater {
                id: repeater2
                model: columns
                DataGridHeaderLabel {
                    text: modelData.title
                    Layout.fillHeight: true
                    Layout.fillWidth: modelData.fillWidth
                    Layout.preferredWidth: w
                    visible: modelData.visible
                    initialWidth: modelData.size !== '*'
                                  ? modelData.size : 20
                }
                onItemAdded: if (repeater2.count === columns.length) isReady = true
            }
        }

        SplitView {
            id: splitView
            clip: true
            visible: fitColumn
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
                    PropertyChanges {
                        target: splitView
                        width: {
                            var _w = 0
                            for (var i = 0; i < repeater.count; ++i)
                                _w += repeater.itemAt(i).width
                            return _w;
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
                    visible: modelData.visible
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
