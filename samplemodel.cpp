#include "samplemodel.h"

#include <QRandomGenerator>

SampleModel::SampleModel(QObject *parent) : QAbstractListModel(parent)
{
    fillSampleData();
}

SampleModel::~SampleModel()
{
    qDeleteAll(_data);
}

int SampleModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return 100;
}

QVariant SampleModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() > 100)
        return QVariant();

    auto row = _data.at(index.row());

    switch (role) {
    case  IdRole:
        return index.row() + 1;

    case NameRole:
        return row->name;

    case LastNameRole:
        return row->lastName;

    case GroupRole:
        return int(index.row() / 10);
    }

    return QVariant();
}

QHash<int, QByteArray> SampleModel::roleNames() const
{
    return {
        {IdRole, "id"},
        {NameRole, "name"},
        {LastNameRole, "last_name"},
        {GroupRole, "group"}
    };
}

void SampleModel::fillSampleData()
{
    for (int i = 0; i < 100; ++i) {
        auto d = new DataEntry;
        d->name = getSampleString();
        d->lastName = getSampleString();
        _data.append(d);
    }
}

QString SampleModel::getSampleString() const
{
    static QString chars = "qwertyuiopasdfghjklzxcvbnm ";
    auto len = QRandomGenerator::global()->bounded(4, 10);
    QString ret;
    for (int i = 0; i < len; ++i) {
        ret.append(chars.midRef(QRandomGenerator::global()->bounded(0, chars.size() - 1), 1));
    }
    return ret;
}
