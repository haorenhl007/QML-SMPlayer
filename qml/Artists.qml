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
import "Config.js" as Config

Window {
    id: artistPage

    HeaderView {
        id: headerView
        pageName: qsTr("Top Artistas")
        currentPage: "artistPage"
        xml: Config.artistDetailXml
    }

    SonicoPage {
        id: page

        ListView {
            id: listView
            anchors {
                fill: parent
                bottomMargin: page.listViewBottomMargin
            }
            model: xmlModel
            delegate: DetailDelegate{}
            clip: true
        }
    }

    XmlListModel {
         id: xmlModel
         source: Config.artistsXML
         query: "/rss/artists/item"

         XmlRole { name: "id"; query: "id/string()" }
         XmlRole { name: "name"; query: "name/string()" }
         XmlRole { name: "songs"; query: "songs/string()" }
         XmlRole { name: "image"; query: "image/string()" }

         onStatusChanged: {
             if (status == XmlListModel.Ready) {
                 console.log("Artistas: ready")
             } else if (status == XmlListModel.Error) {
                 console.log("Artistas Status: error")
             } else if (status == XmlListModel.Loading) {
                 console.log("Artistas: loading")
             }
         }
    }
}
