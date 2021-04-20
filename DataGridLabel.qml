import QtQuick 2.15
import QtQuick.Controls 2.15

Label {
    text: "---"
    anchors.fill: parent
    verticalAlignment: "AlignVCenter"
    clip: true
    elide: "ElideRight"
    leftPadding: 4

    background: Rectangle {
        color: modelData.color
    }
}
