import QtQuick 2.0
import Sailfish.Silica 1.0

Page 
{
    id: page

    SilicaFlickable 
    {
        id: flick
        anchors.fill: parent

        VerticalScrollDecorator { flickable: flick }

        PullDownMenu 
        {
            MenuItem
            {
                text: "About"
                onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))
            }
            MenuItem
            {
                text: "Settings"
                onClicked: pageStack.push(Qt.resolvedUrl("Settings.qml"))
            }
        }

        PushUpMenu
        {
            visible: loggedin && issues.count > 0 && issues.count < searchtotalcount
            MenuItem
            {
                text: "Load more..."
                onClicked: jqlsearch(issues.count)
            }
        }

        contentHeight: column.height + Theme.paddingLarge

        Column 
        {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            
            PageHeader 
            {
                id: pageHeader
                title: "Maira"
            }
            
            Item
            {
                width: parent.width
                height: jql.implicitHeight
                TextArea
                {
                    id: jql
                    label: "JQL"
                    anchors.left: parent.left
                    anchors.leftMargin: Theme.paddingSmall
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width - Theme.itemSizeMedium
                    height: implicitHeight
                    focus: false
                    wrapMode: Text.WrapAnywhere
                    inputMethodHints: Qt.ImhUrlCharactersOnly
                    text: jqlstring.value
                    EnterKey.iconSource: "image://theme/icon-m-search"
                    EnterKey.onClicked:
                    {
                        focus = false
                        jqlstring.value = jql.text
                        if (loggedin)
                            jqlsearch(0)
                        else
                            msgbox.showError("You're not logged in")
                    }
                }
                Column
                {
                    anchors.right: parent.right
                    anchors.rightMargin: Theme.paddingSmall
                    anchors.verticalCenter: parent.verticalCenter

                    IconButton
                    {
                        icon.source: "image://theme/icon-m-favorite"
                        onClicked:
                        {
                            var f = pageStack.push(Qt.resolvedUrl("FilterSelector.qml"), {newjql: jql.text})
                            f.filterselected.connect(function()
                            {
                                jql.text = f.newjql
                                jqlstring.value = f.newjql
                                jqlsearch(0)
                            })
                        }
                    }

                    IconButton
                    {
                        id: searchbutton
                        icon.source: "image://theme/icon-m-search"
                        onClicked:
                        {
                            jql.focus = false
                            jqlstring.value = jql.text
                            if (loggedin)
                                jqlsearch(0)
                            else
                                msgbox.showError("You're not logged in")
                        }
                    }
                }
            }

            DetailItem
            {
                label: "Showing"
                value: issues.count + " of " + searchtotalcount
            }

            Repeater
            {
                model: issues
                delegate: BackgroundItem
                {
                    width: column.width
                    height: Theme.itemSizeLarge
                    onClicked: pageStack.push(Qt.resolvedUrl("IssueView.qml"), {key: key})
                    Column
                    {
                        width: parent.width - Theme.itemSizeExtraSmall - Theme.paddingMedium
                        Row
                        {
                            x: Theme.paddingMedium
                            spacing: Theme.paddingSmall
                            height: Theme.itemSizeExtraSmall/2
                            Image
                            {
                                source: issueicon
                                width: parent.height
                                height: parent.height
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Label
                            {
                                text: key
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                        Label
                        {
                            x: Theme.paddingMedium
                            width: parent.width
                            text: "Assignee: " + assignee
                            font.pixelSize: Theme.fontSizeSmall
                            elide: Text.ElideRight
                        }
                        Label
                        {
                            x: Theme.paddingMedium
                            width: parent.width
                            text: summary
                            font.pixelSize: Theme.fontSizeSmall
                            font.italic: true
                            elide: Text.ElideRight
                        }
                    }
                    Column
                    {
                        anchors.top: parent.top
                        anchors.right: parent.right
                        anchors.rightMargin: Theme.paddingMedium
                        Image
                        {
                            width: Theme.itemSizeExtraSmall / 2
                            height: width
                            source: priorityicon
                        }
                        Image
                        {
                            width: Theme.itemSizeExtraSmall / 2
                            height: width
                            source: statusicon
                        }
                    }
                }
            }
        }
    }
}


