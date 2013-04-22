# Add more folders to ship with the application, here

include(component/component.pri)

folder_01.source = qml
folder_01.target = qml

DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

QT += core gui xml network webkit

# Smart Installer package's UID
# This UID is from the protected range and therefore the package will
# fail to install if self-signed. By default qmake uses the unprotected
# range value if unprotected UID is defined for the application and
# 0x2002CCCF value if protected UID is given to the application
#symbian:DEPLOYMENT.installer_header = 0x2002CCCF

# Allow network access on Symbian

symbian {
      TARGET.CAPABILITY += NetworkServices ReadUserData WriteUserData UserEnvironment #WriteDeviceData ReadDeviceData
      TARGET.EPOCHEAPSIZE = 0x200000 0x8000000
      TARGET.UID3 = 0xE5F3C74D
      #DEPLOYMENT.installer_header=0xA000D7CE

      #vendorinfo = \
      #"%{\"QML-SMPlayer\"}" \
      #":\"QML-SMPlayer\""

      #my_deployment.pkg_prerules = vendorinfo
      #DEPLOYMENT += my_deployment
}

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
CONFIG += mobility
MOBILITY += multimedia

CONFIG += qt-components

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    networkaccessmanagerfactory.cpp \
    customnetworkaccessmanager.cpp \
    useragentprovider.cpp

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    qml/Albums.qml \
    qml/Artists.qml \
    qml/Cover.qml \
    qml/Folders.qml \
    qml/Genres.qml \
    qml/Playlists.qml \
    qml/Songs.qml \
    qml/Components/HeaderView.qml \
    qml/Components/ScroolBar.qml \
    qml/main.qml \
    qml/Player.qml \
    qml/SongDelegate.qml \
    qml/DetailDelegate.qml \
    qml/Storage.js \
    qml/Detail.qml \
    qml/SongDetail.qml \
    qml/Config.js \
    qml/FoldersHeader.qml \
    qml/SonicoPage.qml \
    qml/Menu.qml \
    qml/PlayerControl.qml \
    qml/GenreDetail.qml \
    qml/GenreDetailDelegate.qml \
    qml/Common.js \
    qml/Components/About.qml \
    qml/Components/Help.qml

RESOURCES += \
    QML-SMPlayer_symbian.qrc

HEADERS += \
    networkaccessmanagerfactory.h \
    customnetworkaccessmanager.h \
    useragentprovider.h

TRANSLATIONS = qml/i18n/qml_en_US.ts \
               qml/i18n/qml_pt_BR.ts

CODECFORSRC     = UTF-8
