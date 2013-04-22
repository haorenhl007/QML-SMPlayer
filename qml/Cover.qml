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
import "Toolbar"
import "Components"

Window {
    id: container

    // Building the toolbar, located at the bottom of the app view
    Toolbar {
        id: toolbar

        // This is the first page that will be rendered
        ToolbarView {
            toolbarItemTitle: qsTr("Artistas")
            toolbarItemIcon: "img/icons/m_artists.png"
            clip: true
            source: "Artists.qml"
        }

        ToolbarView {
            toolbarItemTitle: qsTr("Álbumes")
            toolbarItemIcon: "img/icons/m_albums.png"
            clip:  true
            source: "Albums.qml"
        }

        ToolbarView {
            toolbarItemTitle: qsTr("Géneros")
            toolbarItemIcon: "img/icons/m_genres.png"
            clip: true
            source: "Genres.qml"
        }

        ToolbarView {
            toolbarItemTitle: qsTr("Top")
            toolbarItemIcon: "img/icons/m_songs.png"
            clip:  true
            source: "Songs.qml"
        }

        ToolbarView {
            toolbarItemTitle: qsTr("Playlists")
            toolbarItemIcon: "img/icons/m_playlists.png"
            clip: true
            source: "Playlists.qml"
        }

        ToolbarView {
            toolbarItemTitle: qsTr("Folders")
            toolbarItemIcon: "img/icons/m_folders.png"
            clip: true
            source: "Folders.qml"
        }
    }
}
