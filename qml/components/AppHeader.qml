// AppHeader.qml
// 文件说明：页面顶部标题栏组件，用于展示大屏标题和右侧状态文字。
// 组件说明：这是一个可复用 QML 组件，调用方通过属性设置显示内容和背景色。
import QtQuick

Rectangle {
    id: root

    // 接口文档：title 是标题栏主标题，默认值为空字符串，适合绑定页面标题。
    property string title: ""
    // 接口文档：rightText 是标题栏右侧状态文字，默认值为空字符串。
    property string rightText: ""
    // 接口文档：backgroundColor 是标题栏背景色，默认值匹配当前页面深色风格。
    property color backgroundColor: "#132030"

    height: 72
    color: root.backgroundColor

    Text {
        anchors.centerIn: parent
        text: root.title
        color: "#f4f7fb"
        font.family: "Microsoft YaHei"
        font.pixelSize: 28
        font.bold: true
    }

    Text {
        anchors.right: parent.right
        anchors.rightMargin: 24
        anchors.verticalCenter: parent.verticalCenter
        text: root.rightText
        color: "#9fb3c8"
        font.family: "Microsoft YaHei"
        font.pixelSize: 14
    }
}