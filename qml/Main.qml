
import QtQuick
import QtQuick.Controls

ApplicationWindow {
    id: window

    width: 1280
    height: 720
    minimumWidth: 960
    minimumHeight: 540
    visible: true
    title: "Qt + QML 学习项目"
    color: "#101820"

    // 中文注释：property 是 QML 对象上的自定义属性。
    property string pageTitle: "风险预警静态页面"

    Rectangle {
        anchors.fill: parent
        color: "#101820"

        Text {
            anchors.centerIn: parent
            text: window.pageTitle
            color: "#f4f7fb"
            font.family: "Microsoft YaHei"
            font.pixelSize: 36
            font.bold: true
        }
        
    }
}
