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
                    id: statsRow
                    width: parent.width
                    height: 110
                    spacing: 12

                    Repeater {
                        model: MockData.summaryCards

                        delegate: StatCard {
                            width: (statsRow.width - statsRow.spacing * (MockData.summaryCards.length - 1)) / MockData.summaryCards.length
                            height: statsRow.height
                            title: modelData.title
                            value: modelData.value
                            accentColor: modelData.accent
                        }
                    }
                }

                Rectangle {
                    width: parent.width
                    height: centerPanel.height - 220
                    color: "#182638"
                    border.color: "#345f82"
                    border.width: 1

                    Column {
                        anchors.fill: parent
                        anchors.margins: 14
                        spacing: 8

                        Text {
                            text: MockData.centerSections[1]
                            color: "#ffffff"
                            font.family: "Microsoft YaHei"
                            font.pixelSize: 18
                            font.bold: true
                        }

                        Rectangle {
                            width: parent.width
                            height: 34
                            color: "#203247"

                            Row {
                                anchors.fill: parent

                                Repeater {
                                    model: ["企业名称", "风险类型", "标签数", "风险分"]

                                    delegate: Text {
                                        width: index === 0 ? parent.width - 300 : 100
                                        height: parent.height
                                        text: modelData
                                        color: "#dce8f2"
                                        font.family: "Microsoft YaHei"
                                        font.pixelSize: 14
                                        font.bold: true
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                    }
                                }
                            }
                        }

                        ListView {
                            width: parent.width
                            height: parent.height - 84
                            clip: true
                            model: MockData.riskCompanies

                            delegate: Rectangle {
                                width: ListView.view.width
                                height: 34
                                color: index % 2 === 0 ? "#142235" : "#182b40"

                                property var row: modelData

                                Row {
                                    anchors.fill: parent

                                    Text {
                                        width: parent.width - 300
                                        height: parent.height
                                        text: row.company
                                        color: "#dce8f2"
                                        font.family: "Microsoft YaHei"
                                        font.pixelSize: 14
                                        verticalAlignment: Text.AlignVCenter
                                        elide: Text.ElideRight
                                    }

                                    Text {
                                        width: 100
                                        height: parent.height
                                        text: row.type
                                        color: "#dce8f2"
                                        font.family: "Microsoft YaHei"
                                        font.pixelSize: 14
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                    }

                                    Text {
                                        width: 100
                                        height: parent.height
                                        text: row.tags
                                        color: "#dce8f2"
                                        font.family: "Microsoft YaHei"
                                        font.pixelSize: 14
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                    }

                                    Text {
                                        width: 100
                                        height: parent.height
                                        text: row.score
                                        color: "#dce8f2"
                                        font.family: "Microsoft YaHei"
                                        font.pixelSize: 14
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                    }
                                }
                            }
                        }
                    }
                }
            }

            SectionPanel {
                id: rightPanel
                width: 240
                height: parent.height
                title: "异常标签"
                panelColor: window.panelColor
                borderColor: window.panelBorderColor

                Column {
                    width: parent.width
                    spacing: 10

                    Repeater {
                        model: MockData.abnormalTags

                        delegate: Rectangle {
                            width: parent.width
                            height: 52
                            color: index % 2 === 0 ? "#1b2c3e" : "#152538"
                            border.color: modelData.color
                            border.width: 1

                            Text {
                                anchors.left: parent.left
                                anchors.leftMargin: 10
                                anchors.verticalCenter: parent.verticalCenter
                                text: "TOP " + (index + 1) + "  " + modelData.name
                                color: "#dce8f2"
                                font.family: "Microsoft YaHei"
                                font.pixelSize: 13
                            }

                            Text {
                                anchors.right: parent.right
                                anchors.rightMargin: 10
                                anchors.verticalCenter: parent.verticalCenter
                                text: modelData.value.toFixed(1) + "%"
                                color: modelData.color
                                font.family: "Microsoft YaHei"
                                font.pixelSize: 13
                                font.bold: true
                            }
                        }
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
                text: MockData.footerText
                color: "#9fb3c8"
                font.family: "Microsoft YaHei"
                font.pixelSize: 15
            }
        }
    }
}
