import QtQuick 2.0
import Sailfish.Silica 1.0

Page
{
    id: page

    property var projectindex
    signal selected

    SilicaListView
    {
        id: flick
        anchors.fill: parent

        VerticalScrollDecorator { flickable: flick }

        header: SearchField
        {
            width: parent.width
            placeholderText: "Search project"

            onTextChanged:
            {
                projects.update(text)
            }
        }

        currentIndex: -1

        model: projects
        delegate: ListItem
        {
            height: Theme.itemSizeSmall
            width: flick.width
            clip: true

            Row
            {
                anchors.left: parent.left
                anchors.leftMargin: Theme.paddingLarge
                spacing: Theme.paddingLarge
                width: parent.width
                anchors.verticalCenter: parent.verticalCenter

                Image
                {
                    id: avatarimage
                    source: avatarurl
                    anchors.verticalCenter: parent.verticalCenter
                }

                Column
                {
                    anchors.verticalCenter: parent.verticalCenter
                    Label
                    {
                        text: key
                        font.pixelSize: Theme.fontSizeSmall
                    }
                    Label
                    {
                        text: name
                        width: flick.width - 2* Theme.paddingLarge - avatarimage.width - Theme.paddingSmall
                        font.pixelSize: Theme.fontSizeExtraSmall
                        elide: Text.ElideRight
                    }
                }
            }
            BackgroundItem
            {
                anchors.fill: parent
                onClicked:
                {
                    projectindex = index
                    selected()
                }
            }
        }
    }
}
