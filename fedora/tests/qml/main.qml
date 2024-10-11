import QtQuick
import QtQuick.Controls
import QtQuick.Window

ApplicationWindow {
    width: 720
    height: 1280

    visible: true
    title: qsTr("Hello World")
 
    Label {
        text: qsTr("Hello World from Qt Quick")
        anchors.centerIn: parent
    }
    Shortcut {
        sequence: "esc"
        onActivated: Qt.quit()
    }
}
