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
import "Config.js" as Config

Item {
    id: details
    property color textColor: platformStyle.colorNormalDark
    property int currentHeight: window.height
    property variant playerModel: getModel()
    property int totalSongs: !Common.isPage("folderPage") ? playerModel.count : folderListModel.count
    property int nroSong: player.indexSong + 1
    property int minVolume: 3
    property int maxVolume: 10
    property bool isE6: window.height === 480 ? true : false

    function setHeightMargin() {
        if ( isE6 )
            return 105
        else
            return 0
    }

    // Get the right model, could be an XML model or a common model (Folder)
    function getModel() {
        if (Common.isPage("playlistPage") || Common.isPage("folderPage"))
            return player.model
        else if (Common.isPage("topPage"))
            return xmlModel
        else
            return songsModel
    }

    // Go to the previous song and set the right info in the player
    function previous() {
        previousIndex = player.indexSong - 1
            if (previousIndex < 0) {
                previousIndex = playerModel.count - 1
                nextIndex = 0
        }

        player.name = playerModel.get(previousIndex).name
        player.artist = playerModel.get(previousIndex).artist
        player.urlSong = playerModel.get(previousIndex).mp3
        player.refresh()
        player.indexSong = previousIndex
    }

    // Go to the next song and set the right info in the player
    function next() {
        var nextIndex = 0
        nextIndex = player.indexSong + 1
        if (nextIndex >= playerModel.count) {
            nextIndex = 0
            previousIndex = playerModel.count - 1
        }

        player.name = playerModel.get(nextIndex).name
        player.artist = playerModel.get(nextIndex).artist
        player.urlSong = playerModel.get(nextIndex).mp3
        player.refresh()
        player.indexSong = nextIndex
    }

    function getCoverImageUrl(artist) {
        var fullUrl = ""

        if (!artist) {
            fullUrl = "img/artist-default-2.jpg"
        } else {
            var firstLetter = artist.charAt(0)
            var artistName = artist.replace(/ /g,"-");
            artistName = artistName.replace(/'/g,"");
            artistName = artistName.replace(/-&/g,"");
            artistName = artistName.replace(/(À|Á|Â|Ã|Ä|Å|Æ)/gi,'A');
            artistName = artistName.replace(/(È|É|Ê|Ë)/gi,'E');
            artistName = artistName.replace(/(Ì|Í|Î|Ï)/gi,'I');
            artistName = artistName.replace(/(Ò|Ó|Ô|Ö)/gi,'O');
            artistName = artistName.replace(/(Ù|Ú|Û|Ü)/gi,'U');
            artistName = artistName.replace(/(Ñ)/gi,'N');
            var artistImage = artistName + "-2.jpg"
            fullUrl = Config.urlArtistsImage + firstLetter + '/' + artistName + '/' + artistImage
        }

        console.log("fullUrl: " + fullUrl)
        return fullUrl
    }

    width: songRectangle.width; height: listView.height
    opacity: songRectangle.detailsOpacity

    Rectangle {
        id: rect
        anchors {
            top: parent.top
            topMargin: window.inPortrait ? -300 : -35
        }
        height: window.height -(60 + toolBarControlSong.height); width: window.width
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#959494" }
            GradientStop { position: 0.6; color: "#f1f1f1" }
            GradientStop { position: 1.0; color: "#959494" }
        }

        // Return to the song's list
        ToolButton {
            id: songList
            anchors {
                topMargin: 0
                right: parent.right
            }
            iconSource: "img/player/list.svg"
            clip: true
            onClicked: {
                songItem.state = ''
                detailPageBack(headerView.currentPage)
            }
        }
    }

    // To add a song to the playlist
    Button {
        id: playerAdd
        anchors {
            top: details.top
            topMargin: window.inPortrait ? -(details.currentHeight/2  -30) : 0
            left: details.left
            leftMargin: 10
        }
        width: 120
        text: qsTr("Agregar a Playlist")
        font.pixelSize: 13
        iconSource: "img/player/plus.svg"
        visible: Storage.isAdded(player.urlSong)

        MouseArea {
            id: mouseAreaAdd
            anchors.fill: parent
            onClicked: {
                player.addSong(player.name, player.artist, player.urlSong, player.durationTime)
                playerAdd.visible = false
                console.log(player.name + " " + player.artist + " " + player.urlSong)
            }
        }

        states: State {
            name: "pressed"
            when: mouseAreaAdd.pressed
            PropertyChanges { target: playerAdd; checked: true }
        }
    }

    // The song and artist name have the same properties. The folder page doesn't have an artist name
    Text {
        id: songDetailName
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: inPortrait ? playerAdd.bottom : rect.top
            topMargin: inPortrait ? 0 : 10
        }
        y: setHeightMargin()
        text: !Common.isPage("folderPage") ? [player.name,player.artist].join("<br>") : player.name
        horizontalAlignment: Text.Center
        elide: Text.ElideRight
        color: "#1c0c01"
        font {
            pixelSize: platformStyle.fontSizeMedium
            letterSpacing: -1
        }

        // When these names change, we make an effect
        Behavior on text {
            NumberAnimation {
                target: songDetailName
                property: "opacity"
                from: 0
                to: 1
                duration: 1000
            }
        }
    }

    // The song's position in the list and total number of songs in the current page
    Text {
        id: nroTotalSongs
        anchors {
            top: songDetailName.bottom
            topMargin: 5
            horizontalCenter: parent.horizontalCenter
        }
        text: [nroSong,totalSongs].join("/")
        color: "#1c0c01"
        font.pixelSize: platformStyle.fontSizeSmall
    }

    Image {
        id: coverImage
        source: getCoverImageUrl(player.artist)
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: nroTotalSongs.bottom
            topMargin: 5
        }
        width: isE6 ? 120 : 160
        height: isE6 ? 120 : 160
        visible: isE6 || inPortrait
    }

    // Slider to control the volume
    Slider {
        id: volumeSlider
        anchors {
            left: coverImage.right
            leftMargin: inPortrait ? 60 : 180
        }
        y: -30
        width: 10; height: 100
        valueIndicatorVisible: true
        valueIndicatorText: qsTr("Volumen")
        inverted: true
        orientation: Qt.Vertical
        minimumValue: minVolume; maximumValue: maxVolume
        value: Math.floor(player.volume * 10)
        stepSize: 1
        onValueChanged: {
            player.setVolume(value * 0.1)
        }

        Binding {
            target: volumeSlider
            property: "value"
            value: volumeSlider.value
            when: !volumeSlider.pressed
        }
    }

    // Slider to forward the song
    Slider {
        id: slider
        anchors {
            bottom: toolBarControlSong.top
            bottomMargin: -15
            horizontalCenter: parent.horizontalCenter
        }
        width: parent.width - 130
        maximumValue: player.duration
        stepSize: 1000

        onPressedChanged: {
            if (!pressed)
                player.position = value
        }

        Binding {
            target: slider
            property: "value"
            value: player.position
            when: !slider.pressed
        }
    }

    // When doing the streaming, just show the progress bar if the song is not completely loaded (status 6) and not playing
    ProgressBar {
        id: playerLoadingBar
        anchors {
            bottomMargin: -15
            bottom: slider.top
            horizontalCenter: parent.horizontalCenter
        }
        indeterminate: true
        visible: player.currentAudio.status !== 6 && player.playing === true
    }

    // The time so far advanced
    Text {
        id: positionTimeText
        anchors {
            bottom: toolBarControlSong.top
            bottomMargin: 5
            right: slider.left
        }
        text: player.positionTime
        color: textColor
        font.pixelSize: platformStyle.fontSizeSmall
    }

    // The song duration time
    Text {
        id: durationTimeText
        anchors {
            bottom: toolBarControlSong.top
            bottomMargin: 5
            left: slider.right
        }
        text: player.durationTime
        color: textColor
        font.pixelSize: platformStyle.fontSizeSmall
    }

    // Load the player control buttons
    PlayerControl {
        id: toolBarControlSong
        anchors {
            bottom: rect.bottom
        }
    }
}
