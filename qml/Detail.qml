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
import "Config.js" as Config
import "Common.js" as Common

Item {
    id: details
    width: window.width; height: window.height

    ProgressBar {
        id: detailLoadingBar
        anchors.centerIn: parent
        indeterminate: true
        visible: songsModel.status == XmlListModel.Loading
    }

    XmlListModel {
        id: songsModel
        source: !Common.isPage("genrePage") ? headerView.xml + id : Config.artistDetailXml + id
        query: "/rss/songs/item"

        XmlRole { name: "name"; query: "name/string()" }
        XmlRole { name: "artist"; query: "artist/string()" }
        XmlRole { name: "mp3"; query: "mp3/string()" }

        Component.onCompleted: console.log(songsModel.source)
    }

    ListView {
        id: songsView
        anchors {
            fill: parent
            topMargin: 60
            bottomMargin: 120
        }
        model: songsModel
        delegate: SongDelegate{}
        cacheBuffer: height
        clip: true
    }
}
