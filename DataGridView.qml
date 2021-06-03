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

    topPadding: 1
    bottomPadding: 1
    leftPadding: 1
    rightPadding: 1

    onColumnsChanged: {
        for (var i = 0; i < columns; i++)
            widthModel.append({size: -1})
    }

    DataGridHeader {
        id: headerRow
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        columns: root.columns

        fitColumn: root.fitColumns

        endMargin: verticalScrollBar.width
        horizontalLine: root.headerSepratorLine
        borderColor: root.borderColor
        color: root.headerBackgroundColor

        Component.onCompleted: listRepeater.model = root.model
    }

    ListView {
        id: listRepeater

        anchors {
            top: headerRow.bottom
            left: parent.left
            bottom: parent.bottom
            right: parent.right
        }
        ScrollBar.vertical: ScrollBar{
            id: verticalScrollBar
            policy: ScrollBar.AlwaysOn
        }
        ScrollBar.horizontal: ScrollBar{
            id: horizontalScrollBar
            policy: ScrollBar.AsNeeded
        }


        headerPositioning: ListView.OverlayHeader
        clip: true

        delegate: DataGridRow {
            width: parent == null ? 0 : (fitColumns ? parent.width : headerRow.actualWidth)
//            width: parent.width
            //                parent=== null ? 0 : parent.width - verticalScrollBar.width
            header: headerRow
            columns: root.columns
            borderColor: root.borderColor
            horizontalLine: root.horizontalLines
            verticalLine: root.verticalLines

            onClicked: root.rowClicked(model)
            onDoubleClicked: root.rowDoubleClicked(model)
        }
    }
/*
    Flickable {
        id: tableView
        clip: true
        visible: false
        boundsBehavior: Flickable.StopAtBounds
        contentWidth: headerRow.actualWidth
        contentHeight: listLayout.height

        rightMargin: verticalScrollBar.width
        bottomMargin: horizontalScrollBar.active ? horizontalScrollBar.height : 0

        ScrollBar.vertical: ScrollBar{
            id: verticalScrollBar
            policy: ScrollBar.AlwaysOn
        }
        ScrollBar.horizontal: ScrollBar{
            id: horizontalScrollBar
            policy: ScrollBar.AsNeeded
        }
        anchors {
            top: headerRow.bottom
            left: parent.left
            bottom: parent.bottom
            right: parent.right
        }

        ColumnLayout {
            id: listLayout
            spacing: 0
            width: parent.width
            clip: true
            Repeater {
                id: listRepeater
                delegate: DataGridRow {
//                    width: fitColumns ? parent.width : headerRow.actualWidth
                    width: parent.width
                    //                parent=== null ? 0 : parent.width - verticalScrollBar.width
                    header: headerRow
                    columns: root.columns
                    borderColor: root.borderColor
                    horizontalLine: root.horizontalLines
                    verticalLine: root.verticalLines

                    onClicked: root.rowClicked(model)
                    onDoubleClicked: root.rowDoubleClicked(model)
                }
            }
        }
    }
    */
}
