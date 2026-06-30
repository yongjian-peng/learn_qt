#include <QDir>
#include <QFile>
#include <QFileInfo>
#include <QtTest>

class SmokeTest : public QObject
{
    Q_OBJECT

private slots:
    void projectSkeletonFilesExist();
    void mainLoadsQmlResource();
    void mainQmlDefinesDashboardFrame();
    void buildDeploysQtRuntime();
};

void SmokeTest::projectSkeletonFilesExist()
{
    const QDir root(QStringLiteral(TEST_SOURCE_DIR));

    const QStringList files{
        QStringLiteral("CMakeLists.txt"),
        QStringLiteral("src/main.cpp"),
        QStringLiteral("qml/Main.qml"),
        QStringLiteral("qml/qml.qrc")
    };

    for (const QString& file : files) {
        QVERIFY2(QFileInfo::exists(root.filePath(file)), qPrintable(file));
    }
}

void SmokeTest::mainLoadsQmlResource()
{
    const QDir root(QStringLiteral(TEST_SOURCE_DIR));
    QFile file(root.filePath(QStringLiteral("src/main.cpp")));
    QVERIFY(file.open(QIODevice::ReadOnly | QIODevice::Text));

    const QByteArray source = file.readAll();
    QVERIFY(source.contains("qrc:/qml/Main.qml"));
}

// 验证第 2 步页面框架包含顶部、三列主体和底部区域
void SmokeTest::mainQmlDefinesDashboardFrame()
{
    const QDir root(QStringLiteral(TEST_SOURCE_DIR));
    QFile file(root.filePath(QStringLiteral("qml/Main.qml")));
    QVERIFY(file.open(QIODevice::ReadOnly | QIODevice::Text));

    const QByteArray source = file.readAll();
    QVERIFY(source.contains("id: topBar"));
    QVERIFY(source.contains("id: leftPanel"));
    QVERIFY(source.contains("id: centerPanel"));
    QVERIFY(source.contains("id: rightPanel"));
    QVERIFY(source.contains("id: footerBar"));
    QVERIFY(source.contains("Row {"));
    QVERIFY(source.contains("Column {"));
    QVERIFY(source.contains("anchors.top:"));
}

void SmokeTest::buildDeploysQtRuntime()
{
    const QDir binDir(QDir(QStringLiteral(TEST_BINARY_DIR)).filePath(QStringLiteral("bin")));

    const QStringList runtimeFiles{
        QStringLiteral("Qt6Core.dll"),
        QStringLiteral("Qt6Gui.dll"),
        QStringLiteral("Qt6Qml.dll"),
        QStringLiteral("Qt6Quick.dll"),
        QStringLiteral("Qt6QuickControls2.dll")
    };

    for (const QString& file : runtimeFiles) {
        QVERIFY2(QFileInfo::exists(binDir.filePath(file)), qPrintable(file));
    }
}

QTEST_MAIN(SmokeTest)
#include "test_smoke.moc"
