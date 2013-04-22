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
import "Components"
import "Storage.js" as Storage
import "Common.js" as Common

Window {
    id: playlistPage

    // Call the database playlist items when page is loading
    Component.onCompleted: {
        Storage.initialize()
        Storage.getPlaylist(player.model)
        listView.positionViewAtEnd()
    }

    HeaderView {
        id: headerView
        pageName: qsTr("Mi Playlist")
        currentPage: "playlistPage"
    }

    SonicoPage {
        id: page

        ListView {
            id: listView
            anchors {
                fill: parent
                bottomMargin: page.listViewBottomMargin
            }
            model: player.model
            delegate: SongDelegate{}
            clip: true
        }

        // Make this text visible only when we have no songs
        Text {
            id: noSongsText
            anchors.centerIn: parent
            text: qsTr("Aun no haz agregado canciones.")
            color: "black"
            visible: player.model.count === 0 && Common.isPage("playlistPage") && player.activeAds == false
        }
    }

    // This button will only appears if there is at least one song
    Button {
        id: deleteAllButton
        anchors.horizontalCenter: parent.horizontalCenter
        y: window.height - page.listViewBottomMargin
        width: 130; height: 40
        text: qsTr("Quitar Todo")
        font.pixelSize: platformStyle.fontSizeMedium
        clip: true
        visible: player.model.count > 0 && Common.isPage("playlistPage")

        MouseArea {
            id: mouseAreaC
            anchors.fill: parent
            onClicked: queryDialog.open()
        }

        states: State {
            name: "pressed"
            when: mouseAreaC.pressed
            PropertyChanges { target: deleteAllButton; checked: true }
        }
    }

    QueryDialog {
        id: queryDialog
        anchors.centerIn: parent
        acceptButtonText: qsTr("Si")
        rejectButtonText: qsTr("No")
        titleText: qsTr("¿Estás seguro de quitar todo?")
        message: qsTr("¿Seguro de quitar todo?")

        onAccepted: {
            player.model.clear()
            Storage.deleteAll()
        }
    }
}
