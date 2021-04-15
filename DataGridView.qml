import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQml.Models 2.15

Frame {
    id: root

    property color borderColor: 'red'
    property color headerBackgroundColor: 'red'

    property alias model: tableView.model
    property alias count: tableView.count
    signal rowClicked(var model)

    default property list<DataGridColumn> columns

    property bool horizontalLines: true
    property bool verticalLines: true
    property bool headerSepratorLine: horizontalLines

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

        horizontalLine: root.headerSepratorLine
        borderColor: root.borderColor
        backgroundColor: root.headerBackgroundColor
    }

    ListView {
        id: tableView
        clip: true
        boundsBehavior: Flickable.StopAtBounds

        anchors {
            top: headerRow.bottom
            left: parent.left
            bottom: parent.bottom
            right: parent.right
        }
        delegate: DataGridRow {
            header: headerRow
            columns: root.columns
            borderColor: root.borderColor
            horizontalLine: root.horizontalLines
            verticalLine: root.verticalLines

            onClicked: root.rowClicked(model)
        }
    }
}
