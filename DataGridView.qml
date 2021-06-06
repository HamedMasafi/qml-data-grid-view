import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQml.Models 2.15

Frame {
    id: root

    property color borderColor: 'red'
    property color headerBackgroundColor: 'red'

    property var model
    property alias count: listRepeater.count
    signal rowClicked(var model)
    signal rowDoubleClicked(var model)

    default property list<DataGridColumnBase> columns

    property bool horizontalLines: true
    property bool verticalLines: true
    property bool headerSepratorLine: horizontalLines
    property bool fitColumns: true
    property var currentValue: listRepeater.currentItem._model

    topPadding: 1
    bottomPadding: 1
    leftPadding: 1
    rightPadding: 1

    onColumnsChanged: {
        for (var i = 0; i < columns; i++)
            widthModel.append({size: -1})
    }

    ListView {
        id: listRepeater

        property DataGridHeader headerRow: null

        displayMarginBeginning: 150

        anchors.fill: parent
        z: 1
        boundsBehavior: Flickable.StopAtBounds

        ScrollBar.vertical: ScrollBar{
            id: verticalScrollBar
            policy: ScrollBar.AlwaysOn
        }
        ScrollBar.horizontal: ScrollBar{
            id: horizontalScrollBar
            policy: ScrollBar.AsNeeded
        }

        Rectangle {
            anchors.fill: parent
            border.color: borderColor
            border.width: 1
            color: 'transparent'
            z:  0
            visible: false
        }

        headerPositioning: ListView.OverlayHeader
        header: DataGridHeader {
            id: _headerRow2
            width: parent.width - verticalScrollBar.width
//                        anchors.left: parent.left
//                        anchors.right: parent.right
//                        anchors.top: parent.top
            columns: root.columns

            fitColumn: root.fitColumns

            endMargin: verticalScrollBar.width
            horizontalLine: root.headerSepratorLine
            borderColor: root.borderColor
            color: root.headerBackgroundColor

            z: 10

            Component.onCompleted: {
                listRepeater.headerRow = _headerRow2
                listRepeater.model = root.model
            }
        }

        clip: true

        delegate: DataGridRow {
            property var _model: model

            width: parent == null ? 0 : (fitColumns ? parent.width : listRepeater.headerRow.actualWidth)
            //            width: parent.width
            //                parent=== null ? 0 : parent.width - verticalScrollBar.width
            z: 9
            header: listRepeater.headerRow
            columns: root.columns
            borderColor: root.borderColor
            horizontalLine: root.horizontalLines
            verticalLine: root.verticalLines
            checked: listRepeater.currentIndex == index
            onClicked: {
                listRepeater.currentIndex = index
                root.rowClicked(model)
            }
            onDoubleClicked: root.rowDoubleClicked(model)
        }
    }
}
