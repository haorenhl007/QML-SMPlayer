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
import Qt.labs.folderlistmodel 1.0
import "Components"

Window {
    id: folderPage

    HeaderView {
        id: headerView
        pageName: qsTr("Folders")
        currentPage: "folderPage"
    }

    SonicoPage {
        id: page

        FoldersHeader {
            y: 50
            visible: player.activeAdsFolder
        }

        ListView {
            id: listView
            anchors {
                fill: parent
                topMargin: 80
                bottomMargin: page.listViewBottomMargin
            }
            model: folderListModel
            delegate: SongDelegate{}
            cacheBuffer: height
            clip: true
            section.property: "artist"
            section.criteria: ViewSection.FullString
            pressDelay: 100
        }
    }

    // The folder List Model only filter mp3 files. The default folder is the download directory. (Already created in the mobile phone)
    FolderListModel {
        id: folderListModel
        nameFilters: ["*.mp3"]
        sortField: FolderListModel.Type
        folder: "file://"
        showOnlyReadable: true
    }
}
