TARGET = harbour-maira
QT += network
CONFIG += sailfishapp

DEFINES += "APPVERSION=\\\"$${SPECVERSION}\\\""
DEFINES += "APPNAME=\\\"$${TARGET}\\\""

icons.files = icons/*
icons.path = /usr/share/icons/hicolor/
INSTALLS += icons

OTHER_FILES += qml/maira.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-maira.spec \
    harbour-maira.desktop \
    icons/86x86/apps/harbour-maira.png \
    qml/pages/Settings.qml \
    qml/pages/IssueView.qml \
    qml/pages/MainPage.qml \
    qml/pages/CommentView.qml \
    qml/pages/AddCommentDialog.qml \
    qml/pages/About.qml \
    qml/pages/AttachmentView.qml \
    qml/components/Messagebox.qml \
    qml/components/DetailUserItem.qml

SOURCES += \
    src/main.cpp \
    src/filedownloader.cpp

HEADERS += \
    src/filedownloader.h
