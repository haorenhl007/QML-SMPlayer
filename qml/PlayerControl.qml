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
import "Common.js" as Common

ToolBar {
    id: toolBarControlSong

    tools: ToolBarLayout {

        ToolButton {
            flat: true
            iconSource: "img/player/repeat.svg"
            checkable:true
            checked: player.repeat
            onCheckedChanged: player.repeat = checked
        }

        ButtonRow {

            ToolButton {
                id: playerPrevious
                iconSource: "toolbar-mediacontrol-backwards"
                visible: !Common.isPage("folderPage")
                MouseArea {
                    anchors.fill: parent
                    onClicked: { player.position = 0;  previous() }
                }
            }

            ToolButton {
                id: playerStop
                iconSource: "toolbar-mediacontrol-stop"
                MouseArea {
                    anchors.fill: parent
                    onClicked: player.stop()
                }
            }

            ToolButton {
                id: playerPlayPause
                iconSource: player.playing ? "toolbar-mediacontrol-pause" : "toolbar-mediacontrol-play"
                MouseArea {
                    anchors.fill: parent
                    onClicked: player.playing ? player.pause() : player.play()
                }
            }

            ToolButton {
                id: playerNext
                iconSource: "toolbar-mediacontrol-forward"
                visible: !Common.isPage("folderPage")
                MouseArea {
                    anchors.fill: parent
                    onClicked: { player.position = 0; next() }
                }
            }
        }
   }
}
