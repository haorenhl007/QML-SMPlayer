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

#include "customnetworkaccessmanager.h"
#include "useragentprovider.h"
#include <QNetworkReply>

CustomNetworkAccessManager::CustomNetworkAccessManager(QString p_userAgent, QObject *parent) :
    QNetworkAccessManager(parent), __userAgent(p_userAgent)
{
}

QNetworkReply *CustomNetworkAccessManager::createRequest( Operation op,
                                                          const QNetworkRequest &req,
                                                          QIODevice * outgoingData )
{
    QNetworkRequest new_req(req);
    new_req.setRawHeader("User-Agent", __userAgent.toAscii());

    QNetworkReply *reply = QNetworkAccessManager::createRequest( op, new_req, outgoingData );
    return reply;
}
