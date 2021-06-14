import QtQuick 2.15
import QtQuick.Window 2.15
import Test 1.0
import QtQuick.Controls.Material 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt.labs.settings 1.1

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    SampleModel {
        id: sampleModel
    }

    Settings {
        property alias horizontalLines: horizontalLinesCheckbox.checked
        property alias verticalLines: verticalLinesCheckbox.checked
        property alias seprateHeaderLine: seprateHeaderLineCheckbox.checked
        property alias fit: fitCheckbox.checked
    }

    Component {
        id: hilightComponent
        Rectangle {
//            property ListView listView: null

            color: 'red'
            radius: 5
        //    visible: (listView != null && listView.currentItem != null)
            y: (ListView.view.currentIndex !== -1)
               ? ListView.view.currentItem.y : 0

            height: (ListView.view.currentIndex !== -1)
               ? ListView.view.currentItem.height : 0

            width: ListView.view.width - 16

            Behavior on y {
                SpringAnimation {
                    duration: 300
                    spring: 3
                    damping: 0.2
                }
            }
        }

    }

    menuBar: MenuBar {
        Menu {
            title: "View"

            MenuItem {
                id: horizontalLinesCheckbox
                text: "Horizontal lines"
                checkable: true
            }
            MenuItem {
                id: verticalLinesCheckbox
                text: "Vertical lines"
                checkable: true
            }
            MenuItem {
                id: seprateHeaderLineCheckbox
                text: "Sepraete line"
                checkable: true
            }

        }
        Menu {
            title: "Behavior"

            MenuItem {
                id: fitCheckbox
                text: "Fit columns"
                checked: true
            }
            MenuItem {
                text: "Hilight second col"
                checkable: true
                onCheckedChanged: col2.color = checked ? 'yellow' : 'transparent'
            }

            MenuSeparator {}

            MenuItem {
                text: "Show selected"
                onClicked: {
                    console.log(dataGridView.currentValue.name)
                }
            }
        }
    }

    DataGridView {
        id: dataGridView
        anchors.fill: parent
        anchors.margins: 9

        model: sampleModel

        borderColor: Material.dropShadowColor
        headerBackgroundColor: 'gray'

        fitColumns: fitCheckbox.checked

        horizontalLines: horizontalLinesCheckbox.checked
        verticalLines: verticalLinesCheckbox.checked
        headerSepratorLine: seprateHeaderLineCheckbox.checked

        interactive: true
        highlight: hilightComponent
        keyNavigationEnabled: true
        highlightFollowsCurrentItem: false

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
