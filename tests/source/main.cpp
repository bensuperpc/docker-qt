#include <QApplication>
#include <QDebug>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickWindow>
#include <QtGlobal>
#include <QWidget>

int main(int argc, char* argv[]) {
    qDebug() << "Hello World from Qt" << qVersion();

    if (argc > 1 && QString(argv[1]) == "-cli") {
        return 0;
    }
    
    QApplication app(argc, argv);
    QQmlApplicationEngine engine;

    const QUrl url(u"qrc:/bensuperpc.org/bensuperpc/qml/main.qml"_qs);

    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated, &app,
        [url](QObject* obj, const QUrl& objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
