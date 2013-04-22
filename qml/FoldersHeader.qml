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
    id: titleBar
    width: parent.width; height: 30
    gradient: Gradient {
        GradientStop { position: 0.0; color: "#4a4949" }
        GradientStop { position: 1.0; color: "#171717" }
    }

    SystemPalette { id: palette }

    Rectangle {
        id: upButton
        width: 50; height: parent.height
        color: "transparent"

        Image { anchors.centerIn: parent; width: 30; height: 30; source: "img/icons/folder_up.png" }

        MouseArea {
            id: upRegion;
            anchors.fill: parent
            onClicked:  {
                if (folderListModel.folder == "")
                    folderListModel.folder = "file:"
                else
                    folderListModel.folder = folderListModel.parentFolder;
            }
        }

        states: State {
            name: "pressed"
            when: upRegion.pressed
            PropertyChanges { target: upButton; color: palette.highlight }
        }
    }

    Rectangle {
        x: 50;
        width: 1; height: parent.height
        color: "gray"
    }

    Text {
        id: textItem
        anchors {
            verticalCenter: parent.verticalCenter
            left: upButton.right;
            right: parent.right;
            leftMargin: 4;
            rightMargin: 4
        }
        height: parent.height
        text: folderListModel.folder
        font.pixelSize: platformStyle.fontSizeSmall
        color: "white"
        elide: Text.ElideLeft
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
    }
}
