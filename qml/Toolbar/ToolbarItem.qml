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

Rectangle {
    property int margin: 10
    property int contentWidth: toolbarItemText.width + margin

    height: parent.minimumItemHeight
    color: "black"

    // Toolbar item background
    BorderImage {
        id: toolbarItemImage
        source: "../img/toolbaritem.png"
        width: parent.width
        height: parent.height
        border {
            left: 0; top: 10
            right: 0; bottom: 10
        }
    }

    // Selection highlight
    BorderImage {
        id: toolbarItemPressedImage
        source: "../img/toolbaritem_p.png"
        width: parent.width
        height: parent.height
        border {
            left: 0; top: 10
            right: 0; bottom: 10
        }
        opacity: toolbar.current == index ? 1 : 0
    }

    // Icon and title
    Column {
        anchors.centerIn: parent

        Image {
            id: toolbarItemIcon
            property string iconSource: toolbar.views[index].toolbarItemIcon
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../" + iconSource
        }

        Text {
            id: toolbarItemText
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 4
            text: toolbar.views[index].toolbarItemTitle
            color: "lightgray"
            style: "Raised"
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: toolbarItemImage
        onClicked: {
            toolbar.setCurrent(index)
            console.log("playingpage: " + player.playingPage)
        }
    }
}
