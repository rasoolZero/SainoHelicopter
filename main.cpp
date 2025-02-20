#include <QFontDatabase>
#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>
#include <QSurfaceFormat>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon(":/assets/icon.png"));

    app.setOrganizationName("rasoolZero");
    app.setApplicationName("SainoHelicopter");

    qint32 fontId = QFontDatabase::addApplicationFont(":/assets/Roboto-Regular.ttf");
    assert(fontId != -1);
    QStringList fontList = QFontDatabase::applicationFontFamilies(fontId);
    QString family = fontList.first();
    QGuiApplication::setFont(QFont(family));

    QSurfaceFormat format;
    format.setSamples(8);
    QSurfaceFormat::setDefaultFormat(format);

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("SainoHelicopter", "Main");

    return app.exec();
}
