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
import "Common.js" as Common

Component {
    id: artistDelegate

    Item {
        id: detailItem
        property real detailsOpacity : 0
        property int imageSize: 50
        property color backgroundColor: "#e4e4e4"
        property color textColor: platformStyle.colorNormalDark

        // The text next to the image, changes depending on the page
        function detailText(page) {
            var detailText = ""
            if (Common.isPage("albumPage")){
                detailText = artist;
            } else if (Common.isPage("genrePage")){
                detailText = [artists,qsTr(" artistas")].join(" ")
            } else {
                detailText = [songs,qsTr(" canciones")].join(" ")
            }
            return detailText
        }

        function getSource() {
            var delegateSource = ""
            if(Common.isPage("genrePage"))
                delegateSource = "GenreDetail.qml"
            else
                delegateSource = "Detail.qml"

            return delegateSource
        }

        width: listView.width; height: 55

        SystemPalette { id: palette }

        Rectangle {
            id: rectangle
            width: parent.width; height: parent.height
            anchors.horizontalCenter: parent.horizontalCenter
            border.color: "#313131"
            color: backgroundColor

            Row {
                id: artistInfo
                x: 12; width: parent.width
                spacing: 10

                Image {
                    id: detailImage
                    y: 3
                    width: imageSize; height: imageSize
                    sourceSize.width: imageSize; sourceSize.height: imageSize
                    source: image
                    cache: true
                }

                Column {
                    width: rectangle.width - detailImage.width - 70; height: detailImage.height

                    Text {
                        id: mainName
                        width: parent.width
                        text: name
                        elide: Text.ElideRight
                        color: textColor
                        font.pixelSize: platformStyle.fontSizeMedium
                        font.letterSpacing: -1
                    }

                    Text {
                        id: detailName
                        text: detailText(headerView.currentPage)
                        color: textColor
                        font.pixelSize: platformStyle.fontSizeSmall
                    }
                }

                ToolButton {
                    id: arrowImage
                    iconSource: "toolbar-next"
                    width: imageSize-10; height: imageSize-10
                    platformInverted: true
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: {
                detailItem.state = 'Detail'
                player.inDetail = true
            }
        }

        Image {
            id: arrowUp
            anchors {
                topMargin: 5
                right: rectangle.right
            }
            opacity: detailItem.detailsOpacity
            source: !Common.isPage("genrePage") ? "img/icons/up.png" : "img/icons/up_genres.png"
            visible: true

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    detailItem.state = ''
                    player.inDetail = false
                }
            }
        }

        Loader {
            id: detailLoader
            visible: source != ""
        }

        Connections {
            target: detailLoader.source != "" ? loader.item : null
        }

        states: [
            State {
                name: "pressed"
                when: mouseArea.pressed
                PropertyChanges { target: rectangle; color: palette.highlight }
            },
            State {
                name: "Detail"
                PropertyChanges { target: arrowImage; visible:false }
                PropertyChanges { target: detailItem; detailsOpacity: 1; x: 0 }
                PropertyChanges { target: detailItem; height: listView.height }
                PropertyChanges { target: detailItem.ListView.view; explicit: true; contentY: detailItem.y }
                PropertyChanges { target: detailItem.ListView.view; interactive: false; }
                PropertyChanges { target: detailItem; backgroundColor: "#767576"; textColor: "white" }
                PropertyChanges { target: detailLoader; source: getSource() }
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
