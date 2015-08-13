import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import "./Component"

Window {
    id: window
    title: qsTr("Hello World")
    width: 640
    height: 480

    SideBar {
        id: sideBarArea
        window: window
        sideBar: Rectangle {
            width: sideBarArea.width / 2
            height: sideBarArea.height
            color: "blue"

            ListView {
                anchors.fill: parent
                model: 10
                delegate: Rectangle {
                    width: parent.width
                    height: 70
                    border.width: 1
                    border.color: "#ccc"
                    Text {
                        anchors.centerIn: parent
                        text: index
                    }
                }
            }

        }
    }

    function showSideBar() {
        sideBarArea.state = "show";
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: MainListView {
            id: mainView
            width: stackView.width
            height: stackView.height

            onRightSideBarIsOpenChanged: {
                if(rightSideBarIsOpen) {
                    highlightRangeMode = ListView.ApplyRange    // 焦点Item允许停止的位置
                } else {
                    highlightRangeMode  = ListView.StrictlyEnforceRange
                }
            }

            onLeftSideBarIsOpenChanged: {
                if(leftSideBarIsOpen) {
                    showSideBar();
                }
            }

            header: Rectangle {
                height: mainView.height
                width: 1
            }
            model:itemsModel

            footerPositioning: ListView.InlineFooter
            footer: Rectangle {
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
        }

        VisualItemModel {
            id: itemsModel
            MyPage {
                id:page
                width: stackView.width
                height: stackView.height

                statusBar: StatusBar {
                    RowLayout {
                        anchors.fill: parent
                        Label { text: "statusBar" }
                    }
                }

                toolBar: ToolBar {
                    RowLayout {
                        anchors.fill: parent
                        Item { Layout.fillWidth: true }
                        Button { text: "nothing"}
                    }
                }
            }

            Page {
                width: stackView.width
                height: stackView.height
                Button {
                    text: "openABigImage"
                    anchors.centerIn: parent
                    onClicked: {
                        stackView.push({item: openABigImage.createObject(), destroyOnPop:true})
                    }
                }
            }
        }
    }

    Component {
        id: openABigImage
        Page {
            width: stackView.width
            height: stackView.height

            toolBar: ToolBar {
                RowLayout {
                    anchors.fill: parent
                    Button {text: "back"; onClicked: stackView.pop(); }
                    Item { Layout.fillWidth: true }
                }
            }
            ScrollView {
                anchors.fill: parent
                // 设置可以使用鼠标拖动
                flickableItem.interactive: true
                Image {
                    source: "./images/bigPic.png"
                    fillMode: Image.PreserveAspectCrop
                }
            }
        }
    }

}
