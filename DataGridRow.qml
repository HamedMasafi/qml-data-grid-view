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

    onClicked: root.rowClicked(model)

    contentItem: Item {
        anchors.fill: parent
        RowLayout {
            property var _d: model
            anchors.fill: parent

            Repeater {
                id: repeater
                Label {
                    id: label
                    property int _w: width
                    text: parent._d[modelData.role]
                    Layout.fillWidth: modelData.fillWidth
                    Layout.preferredWidth: _w

                    verticalAlignment: "AlignVCenter"
                    clip: true
                    elide: "ElideRight"
                    leftPadding: 4

                    Binding {
                        target: label
                        when: header !== null && header.isReady
                        property: "_w"
                        value: header.get(index).width
                    }
                }
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
}
