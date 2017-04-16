#ifndef FILEIO_H
#define FILEIO_H

#include <QObject>
#include <QTextStream>
#include <QFile>

class DataObject : public QObject
{
    Q_OBJECT
public:
    friend class FileIO;

    Q_PROPERTY(QString name READ name WRITE setName)
    Q_PROPERTY(QString time READ time WRITE setTime)
    Q_PROPERTY(QString gender READ gender WRITE setGender)
    Q_PROPERTY(QString age READ age WRITE setAge)
    Q_PROPERTY(QString color READ color WRITE setColor)
    Q_PROPERTY(QString action READ action WRITE setAction)
    Q_PROPERTY(QString object READ object WRITE setObject)
    Q_PROPERTY(QString coord READ coord WRITE setCoord)

    explicit DataObject(QObject *parent = 0);
    DataObject(const QString& name,
               const QString& time,
               const QString& gender,
               const QString& age,
               const QString& color,
               const QString& action,
               const QString& object,
               const QString& coord
               ){
        setName(name);
        setTime(time);
        setGender(gender);
        setAge(age);
        setColor(color);
        setAction(action);
        setObject(object);
        setCoord(coord);
    }

    QString name() { return mName; }
    QString time() { return mTime; }
    QString gender() { return mGender; }
    QString age() { return mAge; }
    QString color() { return mColor; }
    QString action() { return mAction; }
    QString object() { return mObject; }
    QString coord() { return mCoord; }
public slots:
    void setName(const QString& name) { mName = name; }
    void setTime(const QString& time) { mTime = time; }
    void setGender(const QString& gender) { mGender = gender; }
    void setAge(const QString& age) { mAge = age; }
    void setColor(const QString& color) { mColor = color; }
    void setAction(const QString& action) { mAction = action; }
    void setObject(const QString& object) { mObject = object; }
    void setCoord(const QString& coord) { mCoord = coord; }
private:
    QString mName;
    QString mTime;
    QString mGender;
    QString mAge;
    QString mColor;
    QString mAction;
    QString mObject;
    QString mCoord;
};

class FileIO : public QObject
{
    Q_OBJECT
public:

    friend class DataObject;
    Q_PROPERTY(QString source
               READ source
               WRITE setSource
               NOTIFY sourceChanged)
    explicit FileIO(QObject *parent = 0);

    Q_INVOKABLE QList<QObject*> read();
    Q_INVOKABLE bool write(const QString& data);

    QString source() { return mSource; }

public slots:
    void setSource(const QString& source) { mSource = source; }

signals:
    void sourceChanged(const QString& source);
    void error(const QString& msg);

private:
    QString mSource;
};



#endif // FILEIO_H
