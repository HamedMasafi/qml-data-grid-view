import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQml.Models 2.15

ItemDelegate {
    height: 40
    width: parent == null ? 0 : parent.width
    property alias columns: repeater.model
    property DataGridHeader header: null
    property color borderColor: 'gray'
    property bool horizontalLine: true
    property bool verticalLine: true

    contentItem: Item {
        anchors.fill: parent
        RowLayout {
            id: layout
            property var _d: model
            anchors.fill: parent

            Repeater {
                id: repeater
                Item {
                    id: label
                    property int _w: width
                    Layout.fillWidth: modelData.fillWidth
                    Layout.preferredWidth: _w
                    Layout.fillHeight: true

                    Binding {
                        target: label
                        when: header !== null && header.isReady
                        property: "_w"
                        value: header.get(index).width
                    }
                    Label {
                        text: layout._d[modelData.role]
                        anchors.fill: parent
                        verticalAlignment: "AlignVCenter"
                        clip: true
                        elide: "ElideRight"
                        leftPadding: 4

                    }
                    Rectangle {
                        visible: verticalLine && index > 0
                        anchors {
                            left: parent.left
                            bottom: parent.bottom
                            top: parent.top
                        }
                        width: 1
                        color: borderColor
                    }
                }
            }
        }

        Rectangle {
            visible: horizontalLine
            anchors {
                left: parent.left
                bottom: parent.bottom
                right: parent.right
            }
            height: 1
            color: borderColor
        }
    }
}
