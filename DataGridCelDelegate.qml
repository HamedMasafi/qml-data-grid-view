import QtQuick 2.0

Item {
    id: cell
    property Item delegate: null

    onDelegateChanged: {
        delegate.parent = cell
        console.log('new delegate', delegate)
    }
    children: [delegate]

//    color: 'red'
//    Binding {
//        when: delegate !== null
//        target: delegate
////        anchors.fill: parent
//    }
}
