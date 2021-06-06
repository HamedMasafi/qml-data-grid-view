#ifndef SAMPLEMODEL_H
#define SAMPLEMODEL_H

#include <QAbstractListModel>

class SampleModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit SampleModel(QObject *parent = nullptr);
    ~SampleModel();

    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

private:
    enum Roles {
        IdRole = Qt::UserRole + 1,
        NameRole,
        LastNameRole,
        GroupRole
    };
    struct DataEntry {
        QString name;
        QString lastName;
    };
    QList<DataEntry*> _data;
    void fillSampleData();
    QString getSampleString() const;
};

#endif // SAMPLEMODEL_H
