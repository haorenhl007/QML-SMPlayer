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

Dialog {
    id: aboutDialog
    height: window.height
    title: Text {
        text: qsTr("Acerca de QML-SMPlayer")
        color: sonicoTextColor
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
    }

    content: Item {
        id: aboutContent
        property int dialogMargin: 5

        anchors.horizontalCenter: parent.horizontalCenter

        Image {
            id: headerImage
            source: inPortrait ? "../img/about_header.png" : "../img/about_header_lsc.png"
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: parent.dialogMargin*2
            }
        }

        Image {
            id: footerImage
            source: inPortrait ? "../img/about_footer.png" : "../img/about_footer_lsc.png"
            anchors {
                horizontalCenter: parent.horizontalCenter;
                top: headerImage.bottom
            }
        }

        Text  {
            id: aboutText
            anchors {
                top: footerImage.bottom
                topMargin: parent.dialogMargin
            }
            x: inPortrait ? -window.width/2 - parent.dialogMargin : -window.width/2
            width: window.width
            text: qsTr("El mejor sitio de música online.<br>Disfruta de QML-SMPlayer ahora en tu móvil.<br>Top Artistas, Álbumes, Géneros y las últimas canciones<br><br>Crea tu Playlist con más de 100 mil temas disponibles.")
            horizontalAlignment: Text.AlignHCenter
            textFormat: Text.RichText
            wrapMode: Text.WordWrap
            color: headerView.sonicoTextColor
            font {
                pixelSize: 14
                family: platformStyle.fontFamilyRegular
            }
        }

        Text {
            id: versionText
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: aboutText.bottom
                topMargin: parent.dialogMargin
            }
            text: qsTr("Versión 1.5")
            color: headerView.sonicoTextColor
            font {
                pixelSize: 15
                family: platformStyle.fontFamilyRegular
            }
        }

        Button {
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: versionText.bottom
                topMargin: parent.dialogMargin
            }
            text: "OK"
            height: 35
            onClicked: aboutDialog.accept()
        }
    }
}
