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

Component {
    id: artistDelegate

    Item {
        id: detailItemGenre
        property real detailsOpacity : 0
        property int imageSize: 50
        property color backgroundColor: "#e4e4e4"
        property color textColor: platformStyle.colorNormalDark

        width: listView.width; height: 60

        SystemPalette { id: palette }

        Rectangle {
            id: rectangleGenre
            width: parent.width; height: parent.height
            anchors.horizontalCenter: parent.horizontalCenter
            border.color: textColor
            color: backgroundColor

            Row {
                id: artistInfoGenre
                x: 12; width: parent.width
                spacing: 10

                Image {
                    id: detailImage
                    y: 5
                    width: imageSize; height: imageSize
                    sourceSize.width: imageSize; sourceSize.height: imageSize
                    source: image
                    cache: true
                }

                Column {
                    width: rectangleGenre.width - detailImage.width - 70; height: detailImage.height

                    Text {
                        id: mainName
                        width: parent.width
                        text: name
                        elide: Text.ElideRight
                        color: textColor
                        font {
                            pixelSize: platformStyle.fontSizeMedium
                            letterSpacing: -1
                        }
                    }

                    Text {
                        id: detailName
                        text: [songs,qsTr(" canciones")].join(" ")
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
                detailItemGenre.state = 'Detail'
                songsView.anchors.topMargin = 0
            }
        }

        Image {
            id: arrowUp
            anchors {
                topMargin: 5
                right: rectangleGenre.right
            }
            opacity: detailItemGenre.detailsOpacity
            source: "img/icons/up.png"
            visible: true

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    detailItemGenre.state = ''
                    songsView.anchors.topMargin = 60
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
                PropertyChanges { target: rectangleGenre; color: palette.highlight }
            },
            State {
                name: "Detail"
                PropertyChanges { target: arrowImage; visible:false }
                PropertyChanges { target: detailItemGenre; detailsOpacity: 1; x: 0 }
                PropertyChanges { target: detailItemGenre; height: listView.height }
                PropertyChanges { target: detailItemGenre.ListView.view; explicit: true; contentY: detailItemGenre.y }
                PropertyChanges { target: detailItemGenre.ListView.view; interactive: false; }
                PropertyChanges { target: detailLoader; source: "Detail.qml" }
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
