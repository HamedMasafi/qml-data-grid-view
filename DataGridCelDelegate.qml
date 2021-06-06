import QtQuick 2.0

Item {
    id: cell
    property Item delegate: null
    property var model

    onDelegateChanged: {
        delegate.parent = cell
    }
    children: [delegate]

//    color: 'red'
//    Binding {
//        when: delegate !== null
//        target: delegate
////        anchors.fill: parent
//    }
}
