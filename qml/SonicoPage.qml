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
import QtWebKit 1.0
import "Components"
import "Common.js" as Common

// The main container for all the pages
Rectangle {
    id: page
    property int listViewBottomMargin: 120
    property color backgroundViewColor: "#e4e4e4"

    function setVisible() {
        if (Common.isPage("playlistPage") || Common.isPage("folderPage"))
            return false
        else if (xmlModel.status == XmlListModel.Loading)
            return true
        else
            return false
    }

    width: parent.width
    height: parent.height
    y: headerView.height
    color: backgroundViewColor

    // The progressBar doesn't show in the playlist and folder because that content is already loaded.
    ProgressBar {
        id: loadingBar
        anchors.centerIn: parent
        indeterminate: true
        visible: setVisible()
    }

    ScrollBar { scrollArea: listView; height: listView.height; width: 7; anchors.right: listView.right }
}
