import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQml.Models 2.15

ItemDelegate {
    height: 35

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
            anchors {
                top: parent.top
                left: parent.left
                bottom: parent.bottom
            }
            spacing: header.spacing

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
//                                (index == repeater.count - 1 ? 0 : header.spacing)
//                               ((index == repeater.count - 1 || index == 0) ? header.spacing / 2 : header.spacing)
                    }
                    Loader {
                        source: {
                            if (modelData instanceof DataGridColumn || modelData instanceof DataGridColumnBinding || modelData instanceof DataGridColumnCustom)
                                return "DataGridLabel.qml"
                            else if (modelData instanceof DataGridColumnDelegate)
                                return "DataGridCelDelegate.qml"
                        }
                        anchors.fill: parent
                        onLoaded: {
                            if (modelData instanceof DataGridColumnCustom)
                                item.text = model.getTextEvent(layout._d)
                            else if (modelData instanceof DataGridColumnBinding || modelData instanceof DataGridColumn)
                                item.text = layout._d[modelData.role]
                            else if (modelData instanceof DataGridColumnDelegate) {
                                var newItem = modelData.delegate.createObject(item)
                                item.model = layout._d
//                                item.delegate = modelData.delegate
                            }
                        }
                    }

//                    Label {
//                        text: layout._d[modelData.role]
//                        anchors.fill: parent
//                        verticalAlignment: "AlignVCenter"
//                        clip: true
//                        elide: "ElideRight"
//                        leftPadding: 4

//                        background: Rectangle {
//                            color: modelData.color
//                        }
//                    }
                    Rectangle {
                        visible: verticalLine //&& index > 0
                        anchors {
                            right: parent.right
                            bottom: parent.bottom
                            top: parent.top
                            rightMargin: -(header.spacing / 2)
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
                left: layout.left
                bottom: parent.bottom
                right: layout.right
//                rightMargin: 2
            }
            height: 1
            color: borderColor
        }
    }
}
