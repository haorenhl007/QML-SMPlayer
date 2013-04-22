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
import "../Config.js" as Config
import "../Common.js" as Common

Rectangle {
    id: headerView
    property string pageName: ""
    property string currentPage: ""
    property string xml: ""
    property color sonicoTextColor: "white"
    property color musicaTextColor: "#f8c301"
    property color currentSongColor: "#f8d556"
    property color headerMainColor: "#323232"
    property color headerMiddleColor: "#251008"
    property int textSize: window.height === 480 ? 5 : 6

    function setVisibleSort() {
        if ( (Common.isPage("artistPage") || Common.isPage("albumPage") || Common.isPage("topPage")) && player.inDetail == false ) {
            console.log("first: " + player.viewPage)
            console.log("second: " + headerView.currentPage)
            return true
        } else {
            return false
        }
    }

    anchors {
        top: parent.top
        left: parent.left
        right: parent.right
    }
    width: window.width; height: 60
    clip: true

    gradient: Gradient {
        GradientStop { position: 0.0; color: headerMainColor }
        GradientStop { position: 0.5; color: headerMiddleColor }
        GradientStop { position: 1.0; color: headerMainColor }
    }

    ToolButton {
        anchors {
            right: parent.right
            rightMargin: 5
            verticalCenter: parent.verticalCenter
        }
        iconSource: "toolbar-menu"
        onClicked: mainMenu.open()
    }

    Loader {
        id: menuLoader
        height: window.height
        clip: true
        visible: source != ""
    }

    // The top-right menu showing the Home, About, Help, Exit and Cancel options
    Menu {
        id: mainMenu
        anchors.topMargin: -50
        content: MenuLayout {
            MenuItem {
                text: qsTr("Acerca de")
                onClicked: aboutDialog.open()
            }
            MenuItem {
                text: qsTr("Ayuda")
                onClicked: helpDialog.open()
            }
            MenuItem {
                text: qsTr("Salir")
                onClicked: Qt.quit()
            }
            MenuItem {
                width: parent.width
                anchors {
                    left: parent.left
                    leftMargin: 240
                }
                text: qsTr("Cancelar")
                onClicked: mainMenu.close()
            }
        }
    }

    About { id: aboutDialog }
    Help { id: helpDialog }

    Text {
        id: sonicoText
        x: (window.width / 2) - 70
        anchors.topMargin: textSize
        font.pointSize: textSize
        color: sonicoTextColor
        text: "Sonico"
    }

    Text {
        id: musicaText
        anchors {
            topMargin: textSize
            left: sonicoText.right
        }
        font.pointSize: textSize
        color: musicaTextColor
        text: "Musica"
    }

    Text {
        id: comText
        anchors {
            topMargin: textSize
            left: musicaText.right
        }
        font.pointSize: textSize
        color: sonicoTextColor
        text: ".com"
    }

    // The current page name (Ex: Artists, Albums ...)
    Text {
        id: applicationText
        anchors {
            top: sonicoText.bottom
            horizontalCenter: parent.horizontalCenter
        }
        font.pointSize: 5 //headerView.textSize
        color: sonicoTextColor
        text: pageName
    }

    // If there is a song playing, we show its info and animate it in the header view
    Text {
        id: currentSong
        anchors.top: applicationText.bottom
        font.pointSize: 5
        color: currentSongColor
        text: [player.name,player.artist].join(" - ")
        style: Text.Raised
        visible: player.playing === true

        SequentialAnimation on x {
            id: trackAnimation
            running: player.playing === true
            loops: Animation.Infinite
            NumberAnimation { from: 0; to: window.width - 50; duration: 5000 }
            NumberAnimation { from: 0; to: window.width - 50; duration: 5000 }
        }
    }
}

