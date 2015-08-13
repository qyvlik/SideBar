import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import "./Component"

Page {
    id: page
    default property alias data: columnLayout.data
    ScrollView {
        id: content
        focus: true
        anchors.fill: parent
        implicitWidth: page.implicitHeight
        implicitHeight: page.implicitWidth

        // horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
        ColumnLayout {
            id: columnLayout
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
        }
    }
}

