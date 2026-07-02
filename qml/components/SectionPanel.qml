// SectionPanel.qml
// 文件说明：通用区域面板组件，用于左区、中区、右区等页面区域。
// 组件说明：这是一个带标题和内容槽的可复用 QML 组件，调用方把子元素写在组件内部即可。
import QtQuick

Rectangle {
    id: root

    // 接口文档：title 是面板标题，默认值为空字符串。
    property string title: ""
    // 接口文档：panelColor 是面板背景色，默认值匹配当前页面深色风格。
    property color panelColor: "#172331"
    // 接口文档：borderColor 是面板边框色，默认值匹配当前页面边框风格。
    property color borderColor: "#2b4f6f"
    // 接口文档：content 是面板内容槽，调用方写入的子元素会放到标题下方。
    default property alias content: body.data

    color: root.panelColor
    border.color: root.borderColor
    border.width: 1

    Column {
        anchors.fill: parent
        anchors.margins: 18
        spacing: 12

        Text {
            text: root.title
            color: "#ffffff"
            font.family: "Microsoft YaHei"
            font.pixelSize: 22
            font.bold: true
        }

        Column {
            id: body
            width: parent.width
            spacing: 12
        }
    }
}