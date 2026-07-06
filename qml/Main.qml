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
                    height: Math.max(80, Math.min(110, centerPanel.height * 0.18))
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

                Row {
                    id: chartsRow
                    width: parent.width
                    height: Math.max(100, Math.min(170, centerPanel.height * 0.28))
                    spacing: 12

                    Rectangle {
                        width: (chartsRow.width - chartsRow.spacing) / 2
                        height: chartsRow.height
                        color: "#182638"
                        border.color: "#345f82"
                        border.width: 1

                        Text {
                            anchors.left: parent.left
                            anchors.leftMargin: 12
                            anchors.top: parent.top
                            anchors.topMargin: 10
                            text: "趋势折线图"
                            color: "#ffffff"
                            font.family: "Microsoft YaHei"
                            font.pixelSize: 15
                            font.bold: true
                        }

                        Canvas {
                            id: trendCanvas
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.margins: 12
                            anchors.topMargin: 36

                            // 中文注释：onPaint 是 Canvas 的绘图入口，所有 2D 绘图命令都写在这里。
                            onPaint: {
                                var ctx = getContext("2d")
                                ctx.clearRect(0, 0, width, height)

                                var points = MockData.trendPoints
                                if (points.length < 2)
                                    return

                                var left = 30
                                var top = 8
                                var right = width - 8
                                var bottom = height - 22
                                var graphWidth = right - left
                                var graphHeight = bottom - top
                                var maxValue = 1

                                for (var i = 0; i < points.length; ++i)
                                    maxValue = Math.max(maxValue, points[i])

                                ctx.strokeStyle = "rgba(159, 179, 200, 0.24)"
                                ctx.lineWidth = 1
                                for (var line = 0; line <= 3; ++line) {
                                    var y = bottom - graphHeight * line / 3
                                    ctx.beginPath()
                                    ctx.moveTo(left, y)
                                    ctx.lineTo(right, y)
                                    ctx.stroke()
                                }

                                ctx.strokeStyle = "#4aa3df"
                                ctx.lineWidth = 2
                                ctx.beginPath()
                                for (var pointIndex = 0; pointIndex < points.length; ++pointIndex) {
                                    var x = left + graphWidth * pointIndex / (points.length - 1)
                                    var pointY = bottom - graphHeight * points[pointIndex] / maxValue
                                    if (pointIndex === 0)
                                        ctx.moveTo(x, pointY)
                                    else
                                        ctx.lineTo(x, pointY)
                                }
                                ctx.stroke()

                                ctx.fillStyle = "#4aa3df"
                                for (var dotIndex = 0; dotIndex < points.length; ++dotIndex) {
                                    var dotX = left + graphWidth * dotIndex / (points.length - 1)
                                    var dotY = bottom - graphHeight * points[dotIndex] / maxValue
                                    ctx.beginPath()
                                    ctx.arc(dotX, dotY, 3, 0, Math.PI * 2)
                                    ctx.fill()
                                }

                                ctx.fillStyle = "#9fb3c8"
                                ctx.font = "12px Microsoft YaHei"
                                ctx.fillText("Mock 趋势", left, height - 4)
                            }

                            Component.onCompleted: requestPaint()
                            onWidthChanged: requestPaint()
                            onHeightChanged: requestPaint()
                        }
                    }

                    Rectangle {
                        width: (chartsRow.width - chartsRow.spacing) / 2
                        height: chartsRow.height
                        color: "#182638"
                        border.color: "#345f82"
                        border.width: 1

                        Text {
                            anchors.left: parent.left
                            anchors.leftMargin: 12
                            anchors.top: parent.top
                            anchors.topMargin: 10
                            text: "风险等级环形图"
                            color: "#ffffff"
                            font.family: "Microsoft YaHei"
                            font.pixelSize: 15
                            font.bold: true
                        }

                        Canvas {
                            id: ringCanvas
                            width: Math.min(120, parent.width * 0.42)
                            height: Math.min(120, parent.height - 42)
                            anchors.left: parent.left
                            anchors.leftMargin: 12
                            anchors.top: parent.top
                            anchors.topMargin: 40

                            // 这里用 arc 画圆弧，按 value 占比把多个风险等级拼成环形图
                            onPaint: {
                                var ctx = getContext("2d")
                                ctx.clearRect(0, 0, width, height)

                                var levels = MockData.riskLevels
                                var total = 0
                                for (var i = 0; i < levels.length; ++i)
                                    total += levels[i].value
                                if (total <= 0)
                                    return

                                var centerX = width / 2
                                var centerY = height / 2
                                var radius = Math.min(width, height) / 2 - 14
                                var start = -Math.PI / 2

                                ctx.lineWidth = 16
                                ctx.strokeStyle = "rgba(159, 179, 200, 0.18)"
                                ctx.beginPath()
                                ctx.arc(centerX, centerY, radius, 0, Math.PI * 2)
                                ctx.stroke()

                                for (var levelIndex = 0; levelIndex < levels.length; ++levelIndex) {
                                    var item = levels[levelIndex]
                                    var end = start + Math.PI * 2 * item.value / total
                                    ctx.strokeStyle = item.color
                                    ctx.beginPath()
                                    ctx.arc(centerX, centerY, radius, start, end)
                                    ctx.stroke()
                                    start = end
                                }

                                ctx.fillStyle = "#dce8f2"
                                ctx.font = "bold 14px Microsoft YaHei"
                                ctx.textAlign = "center"
                                ctx.textBaseline = "middle"
                                ctx.fillText("等级", centerX, centerY)
                            }

                            Component.onCompleted: requestPaint()
                            onWidthChanged: requestPaint()
                            onHeightChanged: requestPaint()
                        }

                        Column {
                            anchors.left: ringCanvas.right
                            anchors.leftMargin: 12
                            anchors.right: parent.right
                            anchors.rightMargin: 12
                            anchors.verticalCenter: ringCanvas.verticalCenter
                            spacing: 8

                            Repeater {
                                model: MockData.riskLevels

                                delegate: Row {
                                    width: parent.width
                                    height: 18
                                    spacing: 8

                                    Rectangle {
                                        width: 10
                                        height: 10
                                        anchors.verticalCenter: parent.verticalCenter
                                        color: modelData.color
                                    }

                                    Text {
                                        width: parent.width - 18
                                        height: parent.height
                                        text: modelData.name + " " + modelData.value + "%"
                                        color: "#dce8f2"
                                        font.family: "Microsoft YaHei"
                                        font.pixelSize: 13
                                        verticalAlignment: Text.AlignVCenter
                                        elide: Text.ElideRight
                                    }
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    width: parent.width
                    height: Math.max(88, centerPanel.height - statsRow.height - chartsRow.height - 130)
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
