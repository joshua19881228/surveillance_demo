#include "fileio.h"
#include <QFile>

DataObject::DataObject(QObject *parent) :
    QObject(parent)
{

}



FileIO::FileIO(QObject *parent) :
    QObject(parent)
{

}

QList<QObject*> FileIO::read()
{
    QList<QObject*> dataList;
    if (mSource.isEmpty()){
        emit error("source is empty");
        return dataList;
    }

    QFile file(mSource);
    QString fileContent;

    if ( file.open(QIODevice::ReadOnly) ) {
        QString line;
        QTextStream t( &file );
        while(true) {
            line = t.readLine();
            if (line.isNull())
                break;
            QStringList items = line.split("\t");
            //dataList.append(new DataObject("Item 2", "1:05-1:52", "female", "adult", "red", "run", "luggage", "coord"));
            dataList.append(new DataObject(items[0], items[1], items[2], items[3], items[4], items[5], items[6], items[7]));
         }
        file.close();
    } else {
        emit error("Unable to open the file");
        return dataList;
    }
    return dataList;
}

bool FileIO::write(const QString& data)
{
    if (mSource.isEmpty())
        return false;

    QFile file(mSource);
    if (!file.open(QFile::WriteOnly | QFile::Truncate))
        return false;

    QTextStream out(&file);
    out << data;

    file.close();

    return true;
}
