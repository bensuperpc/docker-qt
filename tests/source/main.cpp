#include <QApplication>
#include <QDebug>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickWindow>
#include <QtGlobal>

// Test include to ensure most Qt modules are available
#include <QtWidgets>
#include <QtQml>
#include <QtQuick>
#include <QtQuickControls2>
#include <QWidget>

int main(int argc, char* argv[]) {
    qDebug() << "Hello World from Qt" << qVersion();

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
