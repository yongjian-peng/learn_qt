import QtQuick
import QtQuick.Controls
import "components"
import "data/MockData.js" as MockData

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
    property string pageTitle: MockData.pageTitle
    property color panelColor: "#172331"
    property color panelBorderColor: "#2b4f6f"

    Rectangle {
        id: pageBackground
        anchors.fill: parent
        color: window.color

        AppHeader {
            id: topBar
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            title: window.pageTitle
            rightText: "Mock"
        }

        Row {
            id: contentRow
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: topBar.bottom
            anchors.bottom: footerBar.top
            anchors.margins: 24
            spacing: 16

            SectionPanel {
                id: leftPanel
                width: 240
                height: parent.height
                title: "左区"
                panelColor: window.panelColor
                borderColor: window.panelBorderColor

                Text {
                    text: MockData.leftItems.join("\n")
                    color: "#b9c8d6"
                    font.family: "Microsoft YaHei"
                    font.pixelSize: 16
                    lineHeight: 1.35
                }
            }

            SectionPanel {
                id: centerPanel
                width: contentRow.width - leftPanel.width - rightPanel.width - contentRow.spacing * 2
                height: parent.height
                title: "中区"
                panelColor: "#0f1b28"
                borderColor: "#3c6f95"

                Row {
                    width: parent.width
                    height: 120
                    spacing: 16

                    StatCard {
                        width: (parent.width - parent.spacing) / 2
                        height: parent.height
                        title: MockData.summaryCards[0].title
                        value: MockData.summaryCards[0].value
                    }

                    StatCard {
                        width: (parent.width - parent.spacing) / 2
                        height: parent.height
                        title: MockData.summaryCards[1].title
                        value: MockData.summaryCards[1].value
                    }
                }

                Rectangle {
                    width: parent.width
                    height: centerPanel.height - 230
                    color: "#182638"
                    border.color: "#345f82"
                    border.width: 1

                    Text {
                        anchors.centerIn: parent
                        text: MockData.centerSections[1]
                        color: "#dce8f2"
                        font.family: "Microsoft YaHei"
                        font.pixelSize: 20
                    }
                }
            }

            SectionPanel {
                id: rightPanel
                width: 240
                height: parent.height
                title: "右区"
                panelColor: window.panelColor
                borderColor: window.panelBorderColor

                Text {
                    text: MockData.rightItems.join("\n")
                    color: "#b9c8d6"
                    font.family: "Microsoft YaHei"
                    font.pixelSize: 16
                    lineHeight: 1.35
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
                text: MockData.footerText
                color: "#9fb3c8"
                font.family: "Microsoft YaHei"
                font.pixelSize: 15
            }
        }
    }
}
