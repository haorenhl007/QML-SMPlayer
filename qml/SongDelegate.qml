/*
 * Copyright (C) 2013 Ronny Yabar <ronnycontacto@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms and conditions of the GNU Lesser General Public License,
 * version 2.1, as published by the Free Software Foundation.
 *
 * This program is distributed in the hope it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
 * more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software Foundation,
 * Inc., 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "Storage.js" as Storage
import "Common.js" as Common

Component {
    id: songDelegate

    Rectangle {
        id: songRectangle
        property color textColor: platformStyle.colorNormalDark
        property color currentTextColor: "#883b04"
        property int extraTopMargin: getExtraTopMargin()
        property real detailsOpacity : 0
        property int previousIndex: index - 1
        property int nextIndex: index + 1

        // In the folder page, there is a few extra margin space
        function getExtraTopMargin() {
            if( Common.isPage("folderPage") )
                return -5
            else
                return 0
        }

        // To know if a song is currently playing or not
        function isCurrent() {
            if ( !Common.isPage("folderPage")) {
                if( player.urlSong == mp3 )
                    return true
                else
                    return false
            } else {
                if( player.urlSong == filePath ) {
                    return true
                } else {
                    return false
                }
            }
        }

        // There are some margins and visible elements differences in the player page
        function detailPage(page) {
            switch (page) {
                case 'topPage':
                    searchBox.visible = false
                    listView.anchors.topMargin = 0
                    break
                case 'playlistPage':
                    deleteAllButton.visible = false
                    break
                case 'folderPage':
                    break
                default:
                    rectangle.visible = false
                    arrowUp.visible = false
                    songsView.anchors.topMargin = 0
                    break
            }
        }

        // We need to set some properties at their original values, when we leave the player
        function detailPageBack(page) {
            switch (page) {
                case 'topPage':
                    searchBox.visible = true
                    listView.anchors.topMargin = 60
                    break
                case 'playlistPage':
                    deleteAllButton.visible = true
                    break
                case 'folderPage':
                    break
                default:
                    rectangle.visible = true
                    arrowUp.visible = true
                    songsView.anchors.topMargin = 60
                    break
            }
        }

        // When clicking in a song, if it is the current one we do nothing, otherwise we play it and set the correct values in the player
        function setPlayerData() {
            if ( isCurrent() ) {
                console.log("Es actual")
            } else {
                if (Common.isPage("folderPage")) {
                    player.name = fileName
                    player.artist = ""
                    player.urlSong = filePath
                } else {
                    player.name = name
                    player.artist = artist
                    player.urlSong = mp3
                }
                player.indexSong = index
                player.refresh()
            }
        }

        // Set the right icon next to the element, it could be a folder or a song in play/pause mode
        function setIcon() {
            var iconSong = ""
            if ( (!isCurrent() && !Common.isPage("folderPage")) || (Common.isPage("folderPage") && !folderListModel.isFolder(index) && !isCurrent()) )
                iconSong =  "img/player/current_track_play.svg"
            else if ((isCurrent() /*&& !Common.isPage("folderPage")*/) || (Common.isPage("folderPage") && !folderListModel.isFolder(index) && isCurrent()) )
                iconSong = "img/player/current_track_pause.svg"
            else
                iconSong = "img/icons/folder.png"

            return iconSong
        }

        // Change the color if it is the current song
        function setTextColor() {
            var color = ""
            if ((!isCurrent() && !Common.isPage("folderPage"))  || (Common.isPage("folderPage") && folderListModel.isFolder(index) || !isCurrent()))
                color = textColor
            else
                color = currentTextColor

            return color
        }

        width: listView.width; height: 55
        color: index % 2 ? "#e4e4e4" : "#b1afaf"

        SystemPalette { id: palette }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: {
                // If the element is a folder, we need to go inside it, otherwise play it.
                if (Common.isPage("folderPage") && folderListModel.isFolder(index)) {
                    if (folderListModel.folder == "") {
                        folderListModel.folder = "file:///" + fileName
                        console.log("Archivo-> " + fileName)
                    } else {
                        folderListModel.folder += "/" + fileName
                        console.log("Directorio-> " + folderListModel.folder)
                    }
                } else {
                    setPlayerData()
                    player.playingPage = headerView.currentPage
                    console.log("urlSong: " + player.urlSong)

                    songItem.state = 'Details'
                    songDetailLoader.source = "SongDetail.qml"
                    detailPage(headerView.currentPage)
                }
            }
        }

        Loader {
            id: songDetailLoader
            anchors {
                top: songRectangle.top
                topMargin: window.inPortrait ? 300 + extraTopMargin : 30 + extraTopMargin
            }
            visible: source != ""
        }

        Connections {
            target: songDetailLoader.source != "" ? songDetailLoader.item : null
        }

        Item {
            id: songItem
            width: listView.width; y:0

            Row {
                id: rowSong
                width: parent.width
                y: 5

                Item {
                    id: imageItem
                    width: 50; height: parent.height
                    anchors.top: parent.top

                    // The icon next to the song or folder
                    Image {
                        id: iconImage
                        anchors {
                            topMargin: 4
                            horizontalCenter: parent.horizontalCenter
                        }
                        source: setIcon()
                    }
                }

                Column {
                    width: (listView.width > 300) ? (parent.width - deleteButton.width - imageItem.width) : (parent.width - deleteButton.width)
                    spacing: 3

                    // Show the folder name in the folder page
                    Text {
                        id: titleText
                        width: parent.width
                        elide: Text.ElideRight
                        text: Common.isPage("folderPage") ? fileName : name
                        font {
                            pixelSize: platformStyle.fontSizeMedium
                            letterSpacing: -1
                        }
                        color: setTextColor()
                    }

                    // There is no artist name in the folder page
                    Text {
                        id: artistText
                        width: parent.width
                        elide: Text.ElideRight
                        text: Common.isPage("folderPage") ? "" : artist
                        font.pixelSize: 16
                        color: isCurrent() ? currentTextColor : textColor
                    }
                }

                // Make the trash icon visible only in the playlist page
                ToolButton {
                    id: deleteButton
                    anchors {
                        top: parent.top
                        rightMargin: 5
                    }
                    visible: Common.isPage("playlistPage")
                    iconSource: "img/icons/trash.png"
                    onClicked: {
                        player.model.remove(index)
                        Storage.deleteItem(mp3)
                    }
                }
            }

            states: [
                State {
                    name: "pressed"
                    when: mouseArea.pressed
                    PropertyChanges { target: songRectangle; color: palette.highlight }
                },
                State {
                    name: "Details"
                    PropertyChanges { target: rowSong; visible:false }
                    PropertyChanges { target: songRectangle; detailsOpacity: 1; color: "#e4e4e4"; x: 0; }
                    PropertyChanges { target: songRectangle; height: listView.height; }
                    PropertyChanges { target: songRectangle.ListView.view; explicit: true; contentY: songRectangle.y }
                }
            ]

            transitions: Transition {
                ParallelAnimation {
                    ColorAnimation { property: "color"; duration: 500 }
                    NumberAnimation { duration: 300; properties: "detailsOpacity,x,contentY,height,width" }
                }
            }
        }
    }
}
