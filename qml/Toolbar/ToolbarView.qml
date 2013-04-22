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
    id: toolbarViewItem
    property string toolbarItemTitle: ""
    property string toolbarItemIcon: ""
    property url source: ""

    function makeCurrent() {
        pageLoader.source = source
    }

    width: parent.width
    height: parent.height

    Loader {
        id: pageLoader
        anchors.fill: parent
    }

    Behavior on opacity { NumberAnimation { duration: 200} }
}
