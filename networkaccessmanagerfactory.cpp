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

#include "networkaccessmanagerfactory.h"
#include "customnetworkaccessmanager.h"
#include <QtNetwork>
#include <QDesktopServices>

NetworkAccessManagerFactory::NetworkAccessManagerFactory(QString p_userAgent) : QDeclarativeNetworkAccessManagerFactory(), __userAgent(p_userAgent)
{
}

QNetworkAccessManager* NetworkAccessManagerFactory::create(QObject* parent)
{
    CustomNetworkAccessManager* networkManager = new CustomNetworkAccessManager(__userAgent, parent);
    QNetworkDiskCache* diskCache = new QNetworkDiskCache(parent);

    QString cachePath = QDesktopServices::storageLocation(QDesktopServices::CacheLocation);
    QDir().mkpath(cachePath);
    qDebug() << "Caching directory: " + cachePath;

    diskCache->setCacheDirectory(cachePath);
    diskCache->setMaximumCacheSize(10*1024*1024);
    networkManager->setCache(diskCache);

    return networkManager;
}


#include "networkaccessmanagerfactory.h"






