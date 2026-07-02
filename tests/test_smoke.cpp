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
    void mockDataIsWiredIntoQml();
    void mockDataKeepsReadableChinese();
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

// 验证第三步， JS Mock 数据文件被资源系统和 Main.qml 同时接入
void SmokeTest::mockDataIsWiredIntoQml()
{
    const QDir root(QStringLiteral(TEST_SOURCE_DIR));
    QVERIFY(QFileInfo::exists(root.filePath(QStringLiteral("qml/data/MockData.js"))));

    QFile resourceFile(root.filePath(QStringLiteral("qml/qml.qrc")));
    QVERIFY(resourceFile.open(QIODevice::ReadOnly | QIODevice::Text));
    QVERIFY(resourceFile.readAll().contains("qml/data/MockData.js"));

    QFile mainFile(root.filePath(QStringLiteral("qml/Main.qml")));
    QVERIFY(mainFile.open(QIODevice::ReadOnly | QIODevice::Text));
    const QByteArray mainSource = mainFile.readAll();
    QVERIFY(mainSource.contains("import \"data/MockData.js\" as MockData"));
    QVERIFY(mainSource.contains("MockData."));
}

// 验证 Mock 数据使用可读 UTF-8 中文，避免复制 qt-001 里的乱码数据
void SmokeTest::mockDataKeepsReadableChinese()
{
    const QDir root(QStringLiteral(TEST_SOURCE_DIR));
    QFile file(root.filePath(QStringLiteral("qml/data/MockData.js")));
    QVERIFY(file.open(QIODevice::ReadOnly | QIODevice::Text));

    const QByteArray source = file.readAll();
    QVERIFY(source.contains(QString::fromUtf8("风险预警静态页面").toUtf8()));
    QVERIFY(source.contains(QString::fromUtf8("筛查入口").toUtf8()));
    QVERIFY(source.contains(QString::fromUtf8("高风险企业").toUtf8()));
    QVERIFY(!source.contains(QString::fromUtf8("椋庨櫓").toUtf8()));
    QVERIFY(!source.contains(QString::fromUtf8("绛涙煡").toUtf8()));
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
