import QtQuick 2.0
import Sailfish.Silica 1.0

Page
{
    id: page

    property var attachment

    SilicaFlickable
    {
        id: flick
        anchors.fill: parent

        VerticalScrollDecorator { flickable: flick }

        PullDownMenu
        {
            MenuItem
            {
                text: "Dummy menu"
            }
        }

        contentHeight: column.height

        Column
        {
            id: column

            width: page.width
            spacing: Theme.paddingSmall

            PageHeader
            {
                title: attachment.filename
            }

            DetailItem
            {
                label: "Author"
                value: attachment.author
            }
            DetailItem
            {
                label: "Created"
                value: Qt.formatDateTime(new Date(attachment.created), "hh:mm dd.MM.yyyy")
            }

            Image
            {
                id: thumbnail
                anchors.horizontalCenter: parent.horizontalCenter
                source: imagelocation
                Component.onCompleted: fetchimage(attachment.thumbnail)
            }
        }
    }
}


