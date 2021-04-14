import QtQuick 2.15
import QtQuick.Window 2.15
import Test 1.0
import QtQuick.Controls.Material 2.15

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    SampleModel {
        id: sampleModel
    }

    DataGridView {
        anchors.fill: parent
        anchors.margins: 9

        model: sampleModel

        borderColor: Material.dropShadowColor
        headerBackgroundColor: Material.backgroundColor

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
