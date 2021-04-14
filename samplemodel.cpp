#include "samplemodel.h"

#include <QRandomGenerator>

SampleModel::SampleModel(QObject *parent) : QAbstractListModel(parent)
{

}

int SampleModel::rowCount(const QModelIndex &parent) const
{
    return 100;
}

QVariant SampleModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() > 100)
        return QVariant();

    if (role > Qt::UserRole)
        return QRandomGenerator::global()->bounded(0, 100);

    return QVariant();
}

QHash<int, QByteArray> SampleModel::roleNames() const
{
    return {
        {Qt::UserRole + 1, "id"},
        {Qt::UserRole + 2, "name"},
        {Qt::UserRole + 3, "last_name"}
    };
}
