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
    id: helpDialog
    height: window.height
    title: Text { text: qsTr("Ayuda"); color: sonicoTextColor; anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter} }
    content: Item {
        id: aboutContent
        property int dialogMargin: 10

        anchors {
            left: parent.left
            leftMargin: 20
            right: parent.right
            rightMargin: 20
        }
        width: parent.width

        Text {
            id: helpText
            anchors {
                top: parent.bottom
                topMargin: parent.dialogMargin
            }
            width: parent.width
            text: qsTr("QML-SMPlayer móvil es una aplicación Streaming, por lo tanto, para poder escuchar música requieres de una conexión a Internet. A mayor velocidad de conexión, mejor tiempo de respuesta.<br><br>En caso no cuentes con conexión, recuerda que desde la vista Folders también puedes reproducir los archivos almacenados en tu dispositivo.")
            horizontalAlignment: Text.AlignJustify
            textFormat: Text.RichText
            wrapMode: Text.WordWrap
            color: headerView.sonicoTextColor
            font {
                pixelSize: 16
                family: platformStyle.fontFamilyRegular
            }
        }

        Button {
            anchors {
                top: helpText.bottom
                topMargin: parent.dialogMargin
                horizontalCenter: parent.horizontalCenter
            }
            text: "OK"
            height: 35
            onClicked: helpDialog.accept()
        }
    }
}
