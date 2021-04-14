#ifndef SAMPLEMODEL_H
#define SAMPLEMODEL_H

#include <QAbstractListModel>

class SampleModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit SampleModel(QObject *parent = nullptr);

signals:


public:
    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;
};

#endif // SAMPLEMODEL_H
