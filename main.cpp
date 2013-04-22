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

#include <QtGui/QApplication>
#include <QtNetwork>
#include "qmlapplicationviewer.h"
#include "networkaccessmanagerfactory.h"
#include "useragentprovider.h"
#include <QDesktopServices>
#include <QtDeclarative>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    // Localization: Loads the application translation depending on the mobile language.
    QTranslator translator;
    QString locale = QLocale::system().name();
    translator.load("qml_" + locale, ":/qml/i18n/");
    app.installTranslator(&translator);

    UserAgentProvider p;
    QString userAgent = p.getUserAgent();

    NetworkAccessManagerFactory factory(userAgent);

    QmlApplicationViewer viewer;
    viewer.engine()->setNetworkAccessManagerFactory(&factory);
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setSource(QUrl("qrc:///qml/main.qml"));

    // Performance operations
    viewer.setAttribute(Qt::WA_OpaquePaintEvent);
    viewer.setAttribute(Qt::WA_NoSystemBackground);
    viewer.viewport()->setAttribute(Qt::WA_OpaquePaintEvent);
    viewer.viewport()->setAttribute(Qt::WA_NoSystemBackground);
    viewer.window()->showFullScreen();
    viewer.engine()->networkAccessManager()->cache()->clear();

    return app.exec();
}
