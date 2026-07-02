// StatCard.qml
// 文件说明：统计卡片组件，用于展示一个标题和一个数值。
// 组件说明：这是一个可复用 QML 组件，调用方通过 title/value/accentColor 控制显示内容。
import QtQuick

Rectangle {
    id: root

    // 接口文档：title 是统计项名称，默认值为空字符串。
    property string title: ""
    // 接口文档：value 是统计项数值，默认值为空字符串。
    property string value: ""
    // 接口文档：accentColor 是卡片边框强调色，默认值匹配当前页面蓝色边框。
    property color accentColor: "#345f82"

    color: "#1b2c3e"
    border.color: root.accentColor
    border.width: 1

    Column {
        anchors.centerIn: parent
        spacing: 8

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: root.value
            color: "#ffffff"
            font.family: "Microsoft YaHei"
            font.pixelSize: 28
            font.bold: true
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: root.title
            color: "#b9c8d6"
            font.family: "Microsoft YaHei"
            font.pixelSize: 16
        }
    }
    
}