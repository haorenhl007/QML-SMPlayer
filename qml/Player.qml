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
import "Storage.js" as Storage

Item {
    id: player
    property ListModel model: playlistModel
    property Audio currentAudio: audio
    property string name: ""
    property string artist: ""
    property string urlSong: ""
    property real volume: 0.8 // default volume value
    property string error: audio.errorString
    property int duration: audio.source !== "" ? audio.duration : 0
    property string durationTime: audio.source !== "" ? getTime(audio.duration) : ""
    property bool seekable: audio.seekable
    property alias position: audio.position
    property string positionTime: getTime(position)
    property bool playing: false
    property int indexSong: 0
    property int previousSong: indexSong - 1
    property int nextSong: indexSong + 1
    property bool repeat: false
    property string playingPage: ""
    property string viewPage: ""
    property bool activeAds: false
    property bool activeAdsFolder: true
    property bool inDetail: false

    // Convert the song's duration time to a friendly reading
    function getTime(msec) {
        if (msec <= 0 || msec === undefined) {
            return ""

        } else {
            var sec = "" + Math.floor(msec / 1000) % 60
            if (sec.length === 1)
                sec = "0" + sec

            var hour = Math.floor(msec / 3600000)
            if (hour < 1) {
                return Math.floor(msec / 60000) + ":" + sec
            } else {
                var min = "" + Math.floor(msec / 60000) % 60
                if (min.length === 1)
                    min = "0" + min

                return hour + ":" + min + ":" + sec
            }
        }
    }

    // Sets the new volume value
    function setVolume(currentVolume) {
        audio.volume = currentVolume
        volume = currentVolume
    }

    function play() {
        audio.source = urlSong
        playing = true
        audio.play()
    }

    function pause() {
        audio.pause()
        playing = false
    }

    function stop() {
        audio.stop()
        playing = false
    }

    function refresh() {
        stop()
        position = 0

        if (indexSong >= 0) {
            play()
        }
        audio.volume = player.volume
    }

    // Go to the next track in the playlist, once a song has finished.
    function nextPlaylist() {
        if (nextSong >= model.count) {
            nextSong = 0
            previousSong = model.count - 1
        }

        name = model.get(nextSong).name
        artist = model.get(nextSong).artist
        urlSong = model.get(nextSong).mp3
        refresh()
        indexSong = nextSong
    }


    // Add a song to the playlist and save it in the database
    function addSong(name, artist, mp3, duration) {
        Storage.insert(name, artist, mp3, duration)
        player.model.append({"name": name,
                           "artist": artist,
                              "mp3": mp3,
                         "duration": duration})
    }

    ListModel {
        id: playlistModel
    }

    Audio {
        id: audio
        autoLoad: true
        volume: player.volume

        onStatusChanged: {
            // Just go to the next song if the model has more than one element
            if (status == Audio.EndOfMedia && player.playingPage == "playlistPage" && player.model.count > 1 && player.repeat == false) {
                nextPlaylist()
            }

            // Refresh only if the repeater is checked
            if (status == Audio.EndOfMedia && player.repeat == true) {
                refresh()
            }
            console.log("Audio status: " + audio.status)
        }
    }
}
