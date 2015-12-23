#include "filedownloader.h"
#include <QDebug>

FileDownloader::FileDownloader(QQmlEngine *engine, QObject *parent) :
    QObject(parent)
{
    m_engine = engine;
}

void FileDownloader::downloadFile(QUrl url, QString filename)
{
    emit downloadStarted();

    m_filename = filename;
    qDebug() << "downloading" << url << "to" << filename;

    QNetworkAccessManager *nam = m_engine->networkAccessManager();

    QNetworkRequest request(url);
    QNetworkReply *r = nam->get(request);
    connect(r, SIGNAL(finished()), this, SLOT(fileDownloaded()));
}

void FileDownloader::open(QString filename)
{
    QProcess proc;
    QString path = QStandardPaths::writableLocation(QStandardPaths::DownloadLocation) + "/" + filename;

    proc.startDetached("/usr/bin/xdg-open" , QStringList() << path);
}

void FileDownloader::fileDownloaded()
{
    QNetworkReply *pReply = qobject_cast<QNetworkReply *>(sender());

    m_DownloadedData = pReply->readAll();
    int httpstatus = pReply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
    qDebug() << "HttpStatusCode" << httpstatus;

    pReply->deleteLater();

    if (httpstatus == 200)
    {
        QFile file(QStandardPaths::writableLocation(QStandardPaths::DownloadLocation) + "/" + m_filename);
        file.open(QIODevice::WriteOnly);
        file.write(m_DownloadedData);
        file.close();
        emit downloadSuccess();
        open(m_filename);
    }
    else
    {
        emit downloadFailed();
    }
}
