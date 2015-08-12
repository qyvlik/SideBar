import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1

ApplicationWindow {
    title: qsTr("Hello World")
    width: 640
    height: 480

    menuBar: MenuBar {
        Menu {
            title: "Open"
            MenuItem {
                text: "Open..."
                onTriggered: {
                    mainView.showSideBar();
                }
            }
        }
    }

    ListView {
        id: mainView
        focus: true
        anchors.fill: parent
        clip: false
        preferredHighlightBegin: 0
        preferredHighlightEnd: 0
        highlightMoveDuration: 250
        highlightRangeMode: ListView.StrictlyEnforceRange
        //highlightRangeMode: ListView.ApplyRange    // 焦点Item允许停止的位置
        headerPositioning: ListView.OverlayHeader  // header 的位置注意，页面透明的时候慎用
        snapMode: ListView.SnapOneItem
        orientation: ListView.Horizontal
        onCurrentIndexChanged: forceActiveFocus()

        model: 2
        delegate: Rectangle {
            width: mainView.width
            height: mainView.height
            color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
            border.width: 1
            border.color: "#ccc"
        }

        readonly property alias sideBarIsOpen: mainView.__sideBarIsOpen
        property bool __sideBarIsOpen: false

        header: Rectangle {
            width: 200
            height: mainView.height
            color: "yellow"
            ListView {
                anchors.fill: parent
                model: 10
                header: Rectangle {
                    border.color: "#ccc"
                    border.width: 2
                    width: parent.width
                    height: 70
                    Text { anchors.centerIn: parent; text:"side menu" }
                }
                delegate: Rectangle {
                    border.color: "#ccc"
                    border.width: 2
                    width: parent.width
                    height: 70
                    Text { anchors.centerIn: parent; text:index }
                }
            }
        }

        function showSideBar() {
            try {
                highlightRangeMode = ListView.ApplyRange
                contentX = -headerItem.width;
            }catch(e){
                highlightRangeMode  = ListView.StrictlyEnforceRange
            }
        }

        onSideBarIsOpenChanged: {
            console.log(sideBarIsOpen);
            if(sideBarIsOpen) {
                highlightRangeMode = ListView.ApplyRange    // 焦点Item允许停止的位置
            } else {
                highlightRangeMode  = ListView.StrictlyEnforceRange
            }
        }
        onAtXBeginningChanged: {
            try {
                if(atXBeginning) {
                    if( -contentX > headerItem.width) {
                        __sideBarIsOpen = true;
                    }
                } else {
                    __sideBarIsOpen = false;
                }
            } catch(e) {
                // console.log(e)
            }
        }
    }
}
