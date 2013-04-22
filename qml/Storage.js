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

function openDatabase() {
    return openDatabaseSync("QML-SMPlayer", "1.0", "QML-SMPlayer DB", 100000)
}

function initialize() {
    var db = openDatabase()
    db.transaction(
        function(tx) {
            tx.executeSql("CREATE TABLE IF NOT EXISTS playlist(name TEXT, artist TEXT, mp3 TEXT, duration TEXT)")
        }
    )
}

function insert(name, artist, mp3, duration) {
    var db = openDatabase()
    var res = "Error"
    db.transaction(
        function(tx) {
            var rs = tx.executeSql("INSERT INTO playlist VALUES (?,?,?,?);", [name, artist, mp3, duration])
            if (rs.rowsAffected > 0)
                res = "OK"
        }
    )
    return res
}

function isAdded(mp3) {
    var db = openDatabase()
    var res = "Unknown"
    db.transaction(
        function(tx) {
            var rs = tx.executeSql("Select mp3 FROM playlist WHERE mp3=?;", [mp3])
            if (rs.rows.length > 0) {
                res = "false"
            } else {
                res = "true"
            }
        }
    )
    return res
}

function deleteItem(mp3) {
    var db = openDatabase()
    var res = "Unknown"
    db.transaction(
        function(tx) {
            var rs = tx.executeSql("DELETE FROM playlist WHERE mp3=?;", [mp3])
        }
    )
    return res
}

function deleteAll() {
    var db = openDatabase()
    var res = "Unknown"
    db.transaction(
        function(tx) {
            var rs = tx.executeSql("DELETE FROM playlist;")
        }
    )
    return res
}

function getPlaylist(playlistModel) {
    var db = openDatabase()
    var res = "Unknown"
    db.transaction(
        function(tx) {
            var rs = tx.executeSql("SELECT * FROM playlist;")
            if (rs.rows.length > 0) {
                for (var i = 0; i < rs.rows.length; i++) {
                    playlistModel.append({"name": rs.rows.item(i).name,
                                    "artist": rs.rows.item(i).artist,
                                    "mp3": rs.rows.item(i).mp3,
                                    "duration": rs.rows.item(i).duration})
                }
                res = "OK"
            }
        }
    )
    return res
}

function setPlaylist(playlist) {
    var db = openDatabase()
    var res = "Error"
    db.transaction(
        function(tx) {
            var rs = tx.executeSql("SELECT * FROM playlist;")
            var count = 0
            for (var i = 0; i < playlist.count; i++) {
                rs = tx.executeSql("INSERT INTO playlist VALUES (?,?,?,?);",
                    [playlist.get(i).name, playlist.get(i).artist, playlist.get(i).mp3, playlist.get(i).time])
                count += rs.rowsAffected
            }

            if (count > 0)
                res = "OK"
        }
    )
    return res
}

