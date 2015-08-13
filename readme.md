# Sample

SideBar by ListView header

![SideBar by ListView header](demo1.gif)

- highlightRangeMode: ListView.StrictlyEnforceRange
    when sideBarIsOpen is true, set ListView.ApplyRange to highlightRangeMode.

- snapMode: ListView.SnapOneItem

- orientation: ListView.Horizontal

# Complex

- define a [`Page`](Component\Page.qml) qmltype
     - property StatusBar statusBar
     - property ToolBar toolBar

- define a [`MainListView`](Component\MainListView.qml) qmltype
    - atXBeginning && -contentX > headerItem.width is true, then leftSideBarIsOpen is true
    -  atXEnd && contentX > mainView.width is true, then rightSideBarIsOpen is true

- define a [`SideBar`](Component\SideBar.qml) qmltype
    - window
    - state

Define a `Window` window. Set the window to `SideBar::window`.

Define a `Rectangle`. Set this `Rectangle` to `SideBar::sideBar`.

```qml
import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import "./Component"

Window {
    id: window
    width: 640
    height: 480

    SideBar {
        id: sideBarArea
        window: window
        sideBar: Rectangle {
            width: sideBarArea.width / 2
            height: sideBarArea.height
            color: "blue"

            ......
```

Make the MainListView to `StackView::initalItem`.

```qml

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: MainListView {
            id: mainView
            width: stackView.width
            height: stackView.height
            model:itemsModel
```

Base on the `SideBarIsOpen`, set the `ListView::highlightRangeMode`.

```qml
            onRightSideBarIsOpenChanged: {
                if(rightSideBarIsOpen) {
                    highlightRangeMode = ListView.ApplyRange
                } else {
                    highlightRangeMode  = ListView.StrictlyEnforceRange
                }
            }

            onLeftSideBarIsOpenChanged: {
                console.log("leftSideBarIsOpen: ", leftSideBarIsOpen)
                if(leftSideBarIsOpen) {
                    showSideBar();
                }
            }
```

Define a Rectangle to `ListView::header` with nothing.

```qml
            header: Rectangle {
                height: mainView.height
                width: 1
            }

            footer: Rectangle {
                width: 200
                height: mainView.height
                color: "yellow"
                ......
```

Set the itemsModel to `MainListView::model`.

```qml
        VisualItemModel {
            id: itemsModel
            MyPage {
                id:page
                width: stackView.width
                height: stackView.height
                ......
}

```

![Complex](demo2.gif)
