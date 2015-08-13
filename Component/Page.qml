import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4

FocusScope {
    id: page
    focus: true
    implicitWidth: 640
    implicitHeight: 400

    default property alias data: content.data

    property StatusBar statusBar: null
    property ToolBar toolBar: null

    Loader {
        id: panelLoader
        width: page.width
        height: page.height
        focus: page.focus

        onStatusChanged: if (status === Loader.Error) console.error("Failed to load Style for", root)

        Binding { target: toolBar; property: "parent"; value: toolBarParent }
        Binding { target: statusBar; property: "parent"; value: statusBarParent }

        Item {
            id: toolBarParent
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.left: parent.left
            height: children[0] != null ? children[0].height: 0
        }

        Item {
            id: content
            focus: true
            implicitWidth: page.implicitHeight
            implicitHeight: page.implicitWidth

            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: toolBarParent.bottom
            anchors.bottom: statusBarParent.top
        }

        Item {
            id: statusBarParent
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            height: children[0] != null ? children[0].height: 0
        }
    }
}

