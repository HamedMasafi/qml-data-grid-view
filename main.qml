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
        }
    }

    DataGridView {
        anchors.fill: parent
        anchors.margins: 9

        model: sampleModel

        borderColor: Material.dropShadowColor
        headerBackgroundColor: Material.backgroundDimColor

        horizontalLines: horizontalLinesCheckbox.checked
        verticalLines: verticalLinesCheckbox.checked
        headerSepratorLine: seprateHeaderLineCheckbox.checked

        onRowClicked: {
            console.log('row clicked', model.id)
        }

        DataGridColumn {
            role: "id"
            title: "Id"
            size: 100
        }
        DataGridColumn {
            role: "name"
            title: "Name"
            size: 100
        }
        DataGridColumn {
            role: "last_name"
            title: "Last name"
            size: 100
        }
    }
}
