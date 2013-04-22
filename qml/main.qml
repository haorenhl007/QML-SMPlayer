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
import QtMultimediaKit 1.1
import com.nokia.symbian 1.1
import "Storage.js" as Storage

Window {
    id: window
    property int homeTextMargin: inPortrait ? 70 : 110
    property bool isE6: window.height === 480 ? true : false
    property int iconItemMargin: setIconItemMargin()

    Component.onCompleted: {
        Storage.initialize()
    }

    function setBackground() {
        var background = ""
        if (isE6){
            background = "img/background_lsc_640x480.png"
        } else {
            if (inPortrait)
                background = "img/background_prt.png"
            else
                background = "img/background_lsc.png"
        }
        return background
    }

    function setIconItemMargin() {
        if (isE6){
            return 140
        } else {
            if (inPortrait)
                return 300
            else
                return 105
        }
    }

    StatusBar {
        id: statusBar
        anchors.top: parent.top
    }

    Player {
        id: player
    }

    // The background image, it changes depending of the orientation
    Image {
        id: coverImage
        anchors.top: statusBar.bottom
        smooth: true
        source: setBackground()
    }

    // It is empty at the beginning and load one page once it has a source
    Loader {
        id: loader
        anchors.fill: parent
        visible: source != ""
    }

    Connections {
        target: loader.source != "" ? loader.item : null
    }

    ListModel {
        id: menuModel
        ListElement { name: QT_TR_NOOP("Artistas"); icon: "img/m_artists.png" }
        ListElement { name: QT_TR_NOOP("Álbumes"); icon: "img/m_albums.png" }
        ListElement { name: QT_TR_NOOP("Géneros"); icon: "img/m_genres.png" }
        ListElement { name: QT_TR_NOOP("Playlists"); icon: "img/m_playlists.png" }
        ListElement { name: QT_TR_NOOP("Folders"); icon: "img/m_folders.png" }
        ListElement { name: QT_TR_NOOP("Top"); icon: "img/m_songs.png" }
        ListElement { name: QT_TR_NOOP("Buscar"); icon: "img/m_search.png" }
    }

    Item {
        id: iconItem
        width: window.width; height: (window.height / 4)
        y: iconItemMargin
        visible: !loader.visible

        Component {
            id: menuDelegate
            Item {
                id:info
                width: 105; height: 105
                scale: PathView.iconScale

                Image {
                    id: menuIcon
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 60; height: 60
                    y: 15;
                    source: icon
                    clip: true
                    smooth: true
                }

                Text {
                    id: iconText
                    anchors {
                        top: menuIcon.bottom
                        horizontalCenter: parent.horizontalCenter
                    }
                    text: qsTr(name)
                    smooth: true
                    color: info.PathView.isCurrentItem ? "#B96820" : "#EFEDE9"
                    font.pixelSize: platformStyle.fontSizeSmall
                }

                MouseArea {
                    id: iconArea
                    anchors.fill: parent
                    onClicked: {
                        loader.source = "Cover.qml"
                        homeText.visible = false
                    }
                }

                states: State {
                    name: "pressed"
                    when: iconArea.pressed
                    PropertyChanges { target: menuIcon; width: 90; height: 90 }
                    PropertyChanges { target: iconText; color: "white" }
                }
            }
        }

        // The icon moving feature
        PathView {
            id: view
            anchors {
                fill: parent
                leftMargin: inPortrait ? 0 : 100
            }
            Keys.onRightPressed: if (!moving) { incrementCurrentIndex(); console.log(moving) }
            Keys.onLeftPressed: if (!moving) decrementCurrentIndex()

            preferredHighlightBegin: 0.5
            preferredHighlightEnd: 0.5
            focus: true
            model: menuModel
            delegate: menuDelegate

            path: Path {
                startX: 10; startY: 50
                PathAttribute { name: "iconScale"; value: 0.5 }
                PathQuad { x: 200; y: 150; controlX: 50; controlY: 200 }

                PathAttribute { name: "iconScale"; value: 1.0 }
                PathQuad { x: inPortrait ? 340 : 440; y: 50; controlX: 360; controlY: 200 }

                PathAttribute { name: "iconScale"; value: 0.5 }
            }
        }
    }

    Text {
        id: homeText
        anchors {
            top: iconItem.bottom
            topMargin: homeTextMargin
            horizontalCenter: parent.horizontalCenter
        }
        text: qsTr("El mejor sitio de Música Online<br>Ahora en tus manos<br><br>Versión 1.5")
        horizontalAlignment: Text.AlignHCenter
        textFormat: Text.RichText
        color: "white"
        style: Text.Outline
        styleColor: platformStyle.colorNormalDark
        font.pixelSize: platformStyle.fontSizeMedium
        font.family: platformStyle.fontFamilyRegular
    }
}
