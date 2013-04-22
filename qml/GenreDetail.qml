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

Item {
    id: details
    width: window.width; height: window.height

    ProgressBar {
        id: detailLoadingBar
        anchors.centerIn: parent
        indeterminate: true
        visible: genreArtistsModel.status == XmlListModel.Loading
    }

    XmlListModel {
         id: genreArtistsModel
         source: Config.genreArtistsXML + id
         query: "/rss/artists/item"

         XmlRole { name: "id"; query: "id/string()" }
         XmlRole { name: "name"; query: "name/string()" }
         XmlRole { name: "songs"; query: "songs/string()" }
         XmlRole { name: "image"; query: "image/string()" }

         onStatusChanged: {
             if (status == XmlListModel.Ready) {
                 console.log("generos artistas ready")
             } else if (status == XmlListModel.Error) {
                 console.log("generos artistas : error")
             } else if (status == XmlListModel.Loading) {
                 console.log("generos artistas : loading")
             }
         }
    }

    ListView {
        id: songsView
        anchors {
            fill: parent
            topMargin: 60
            bottomMargin: 120
        }
        model: genreArtistsModel
        delegate: GenreDetailDelegate{} // here is the trick ->change
        cacheBuffer: height
        clip: true
    }
}
