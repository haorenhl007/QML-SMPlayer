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
import com.nokia.extras 1.1
import "Components"
import "Config.js" as Config

Window {
    id: songPage

    HeaderView {
        id: headerView
        pageName: qsTr("Top Canciones")
        currentPage: "topPage"
        xml: Config.searchXml
    }

    SonicoPage {
        id: page

        SearchBox {
            id: searchBox
            placeHolderText: qsTr("Busca una canción o artista")

            onSearchTextChanged: {
                // Starts searching and reloading the model once the user has typed more than one letter
                if(searchBox.searchText.length > 1) {
                    xmlModel.source = headerView.xml + searchText
                    xmlModel.reload()
                    console.log(xmlModel.source)
                }
            }
        }

        ListView {
            id: listView
            anchors {
                fill: parent
                topMargin: 60
                bottomMargin: page.listViewBottomMargin
            }
            model: xmlModel
            delegate: SongDelegate{}
            clip: true
        }

        // If a song is not found, we set a message
        Text {
            id: resultText
            anchors.centerIn: parent
            text: qsTr("No se encuentran coincidencias")
            color: "black"
            visible: xmlModel.status == XmlListModel.Ready && listView.model.count===0
        }
    }

    XmlListModel {
         id: xmlModel
         source: Config.songsXML
         query: "/rss/songs/item"

         XmlRole { name: "name"; query: "name/string()" }
         XmlRole { name: "artist"; query: "artist/string()" }
         XmlRole { name: "mp3"; query: "mp3/string()" }

         onStatusChanged: {
             if (status == XmlListModel.Ready) {
                 console.log("Top: ready")
             } else if (status == XmlListModel.Error) {
                 console.log("Top Status: error")
             } else if (status == XmlListModel.Loading) {
                 console.log("Top: loading")
             }
         }
    }
}
