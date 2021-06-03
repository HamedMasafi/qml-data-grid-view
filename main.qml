import QtQuick 2.15
import QtQuick.Window 2.15
import Test 1.0
import QtQuick.Controls.Material 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    SampleModel {
        id: sampleModel
    }

    header: ToolBar {
        RowLayout {
            CheckBox {
                id: horizontalLinesCheckbox
                text: "Horizontal lines"
            }
            CheckBox {
                id: verticalLinesCheckbox
                text: "Vertical lines"
            }
            CheckBox {
                id: seprateHeaderLineCheckbox
                text: "Sepraete line"
            }

            CheckBox {
                text: "Hilight second col"
                onCheckedChanged: col2.color = checked ? 'yellow' : 'transparent'
            }
            CheckBox {
                id: fitCheckbox
                text: "Fit columns"
            }
        }
    }

    DataGridView {
        anchors.fill: parent
        anchors.margins: 9

        model: sampleModel

        borderColor: Material.dropShadowColor
        headerBackgroundColor: Material.backgroundDimColor

        fitColumns: fitCheckbox.checked

        horizontalLines: horizontalLinesCheckbox.checked
        verticalLines: verticalLinesCheckbox.checked
        headerSepratorLine: seprateHeaderLineCheckbox.checked

        onRowClicked: {
            console.log('row clicked', model.id)
        }

        DataGridColumnBinding {
            role: "id"
            title: "Id"
            size: 100
            fillWidth: true
        }
        DataGridColumnBinding {
            id: col2
            role: "name"
            title: "Name"
            size: 100
        }
        DataGridColumnBinding {
            role: "last_name"
            title: "Last name"
            size: 100
        }
        DataGridColumnCustom {
            size: 100
            title: "Sample custom"
            getTextEvent: function(model) {
                return "%1-%2".arg(model.name).arg(model.last_name)
            }
        }
        DataGridColumnDelegate {
            title: "Remove button"
            size: 30
            delegate: Button {
                text: "Remove"
                anchors.fill:  parent
                onClicked: console.log("Goint to remove ", parent.model.name, parent.model.last_name)
            }
        }
    }
}
