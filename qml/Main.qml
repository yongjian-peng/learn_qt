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

    // 中文注释：property 是 QML 对象上的自定义属性，后面可以被 Text 直接绑定使用。
    property string pageTitle: "风险预警静态页面"
    property color panelColor: "#172331"
    property color panelBorderColor: "#2b4f6f"

    Rectangle {
        id: pageBackground
        anchors.fill: parent
        color: window.color

        Rectangle {
            id: topBar
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            height: 72
            color: "#132030"

            Text {
                anchors.centerIn: parent
                text: window.pageTitle
                color: "#f4f7fb"
                font.family: "Microsoft YaHei"
                font.pixelSize: 28
                font.bold: true
            }
        }

        Row {
            id: contentRow
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: topBar.bottom
            anchors.bottom: footerBar.top
            anchors.margins: 24
            spacing: 16

            Rectangle {
                id: leftPanel
                width: 240
                height: parent.height
                color: window.panelColor
                border.color: window.panelBorderColor
                border.width: 1

                Column {
                    anchors.fill: parent
                    anchors.margins: 18
                    spacing: 12

                    Text {
                        text: "左区"
                        color: "#ffffff"
                        font.family: "Microsoft YaHei"
                        font.pixelSize: 22
                        font.bold: true
                    }

                    Text {
                        text: "筛查入口\n风险分类\n区域概览"
                        color: "#b9c8d6"
                        font.family: "Microsoft YaHei"
                        font.pixelSize: 16
                        lineHeight: 1.35
                    }
                }
            }

            Rectangle {
                id: centerPanel
                width: contentRow.width - leftPanel.width - rightPanel.width - contentRow.spacing * 2
                height: parent.height
                color: "#0f1b28"
                border.color: "#3c6f95"
                border.width: 1

                Column {
                    anchors.fill: parent
                    anchors.margins: 22
                    spacing: 16

                    Text {
                        text: "中区"
                        color: "#ffffff"
                        font.family: "Microsoft YaHei"
                        font.pixelSize: 24
                        font.bold: true
                    }

                    Rectangle {
                        width: parent.width
                        height: 120
                        color: "#1b2c3e"
                        border.color: "#345f82"
                        border.width: 1

                        Text {
                            anchors.centerIn: parent
                            text: "核心统计区域"
                            color: "#dce8f2"
                            font.family: "Microsoft YaHei"
                            font.pixelSize: 20
                        }
                    }

                    Rectangle {
                        width: parent.width
                        height: parent.height - 176
                        color: "#182638"
                        border.color: "#345f82"
                        border.width: 1

                        Text {
                            anchors.centerIn: parent
                            text: "趋势图 / 表格区域"
                            color: "#dce8f2"
                            font.family: "Microsoft YaHei"
                            font.pixelSize: 20
                        }
                    }
                }
            }

            Rectangle {
                id: rightPanel
                width: 240
                height: parent.height
                color: window.panelColor
                border.color: window.panelBorderColor
                border.width: 1

                Column {
                    anchors.fill: parent
                    anchors.margins: 18
                    spacing: 12

                    Text {
                        text: "右区"
                        color: "#ffffff"
                        font.family: "Microsoft YaHei"
                        font.pixelSize: 22
                        font.bold: true
                    }

                    Text {
                        text: "异常标签\n风险等级\n待处理事项"
                        color: "#b9c8d6"
                        font.family: "Microsoft YaHei"
                        font.pixelSize: 16
                        lineHeight: 1.35
                    }
                }
            }
        }

        Rectangle {
            id: footerBar
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: 44
            color: "#111a25"

            Text {
                anchors.centerIn: parent
                text: "底部状态栏"
                color: "#9fb3c8"
                font.family: "Microsoft YaHei"
                font.pixelSize: 15
            }
        }
    }
}
