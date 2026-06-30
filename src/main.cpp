#include <QCoreApplication>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QTimer>
#include <QUrl>

int main(int argc, char* argv[])
{
    bool smoke = false;
    for (int i = 1; i < argc; ++i)
    {
        const QString arg = QString::fromLocal8Bit(argv[i]);
        if (arg == QStringLiteral("--smoke"))
        {
            smoke = true;
        }
    }

    // 中文注释：QGuiApplication 是 QML 窗口程序的应用入口。
    QGuiApplication app(argc, argv);
    QGuiApplication::setApplicationName(QStringLiteral("QT Learn Lesson"));
    QGuiApplication::setOrganizationName(QStringLiteral("QtLearn"));
    QQuickStyle::setStyle(QStringLiteral("Fusion"));

    QQmlApplicationEngine engine;
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed, &app, []() {
        QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    // qrc:/ 读取 qml.qrc 里打包进入的 QML 文件
    engine.load(QUrl(QStringLiteral("qrc:/qml/Main.qml")));
    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    if (smoke) {
        QTimer::singleShot(0, &app, &QCoreApplication::quit);
    }

    return app.exec();
}
