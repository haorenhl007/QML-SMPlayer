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
import "toolbar.js" as ToolbarJS

Item {
    id: toolbar
    default property alias views: contentArea.children
    property int current: 0
    property int minimumItemHeight: toolbarImage.height
    property int minimumItemWidth: toolbarImage.height

    function setCurrent(index) {
        if (index < views.length) {
            views[index].makeCurrent()
        }
        current = index
    }

    width: parent.width
    height: parent.height

    onCurrentChanged: ToolbarJS.setContentOpacity()
    Component.onCompleted: {
        setCurrent(current)
        ToolbarJS.setContentOpacity()
    }

    Rectangle {
        anchors.fill: parent
        color: "black"
    }

    BorderImage {
        id: toolbarImage
        source: "../img/toolbaritem.png"
        width: 60; height: 60
        border.left: 0; border.top: 10
        border.right: 0; border.bottom: 10
    }

    // Flickable area for the toolbar items
    Flickable {
        id: toolbarItemArea
        anchors {
            bottom: toolbar.bottom
            left: parent.left
            right: parent.right
        }
        height: toolbar.minimumItemHeight
        flickableDirection: "HorizontalFlick"
        contentWidth: toolbarItems.width
        contentHeight: toolbarItems.height
        boundsBehavior: Flickable.StopAtBounds

        Row {
            id: toolbarItems
            property int itemWidth: ToolbarJS.calcTabWidth()

            Repeater {
                id: toolbarItemList
                model: views.length
                delegate: ToolbarItem {
                    width: toolbarItems.itemWidth > contentWidth ? toolbarItems.itemWidth : contentWidth
                    height: toolbar.minimumItemHeight
                }
            }
        }
    }

    Item {
        id: contentArea
        width: toolbar.width
        anchors {
            top: parent.top
            bottom: toolbarItemArea.top
        }
    }
}
