import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQml.Models 2.15

ListView {
    id: root

    //apreance properties
    property color borderColor: 'red'
    property color headerBackgroundColor: 'red'
    property color backgroundColor: 'transparent'

    property bool horizontalLines: true
    property bool verticalLines: true
    property bool headerSepratorLine: horizontalLines
    property bool fitColumns: true

    // signals
    signal rowClicked(var model)
    signal rowDoubleClicked(var model)

    default property list<DataGridColumnBase> columns

    property DataGridHeader headerRow: null
    property var currentValue: currentIndex === -1
                               ? null
                               : currentItem._model

    onColumnsChanged: {
        for (var i = 0; i < columns; i++)
            widthModel.append({size: -1})
    }

    displayMarginBeginning: 150

    boundsBehavior: Flickable.StopAtBounds

    Rectangle {
        anchors.fill: parent
        color: backgroundColor
        border.color: borderColor
        z: -1
    }

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
            root.headerRow = _headerRow2
            root.model = root.model
        }
    }

    clip: true

    delegate: DataGridRow {
        property var _model: model

        width: parent == null ? 0 : (fitColumns ? parent.width : root.headerRow.actualWidth)
        //            width: parent.width
        //                parent=== null ? 0 : parent.width - verticalScrollBar.width
        z: 9
        header: root.headerRow
        columns: root.columns
        borderColor: root.borderColor
        horizontalLine: root.horizontalLines
        verticalLine: root.verticalLines
        checked: root.currentIndex == index
        onClicked: {
            root.currentIndex = index
            root.rowClicked(model)
        }
        onDoubleClicked: root.rowDoubleClicked(model)
    }
}
