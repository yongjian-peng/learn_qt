// MockData.js
// 第 3-5 步学习 JS 数据文件。这里用静态数组对象模拟页面数据，后面再替换为真实接口数据。
.pragma library

var pageTitle = "风险预警静态页面"

var leftItems = [
    "筛查入口",
    "风险分类",
    "区域概览"
]

var rightItems = [
    "异常标签",
    "风险等级",
    "待处理事项"
]

var summaryCards = [
    { title: "监控企业", value: "12,860", accent: "#3c8dbc" },
    { title: "高风险企业", value: "328", accent: "#d65a4a" },
    { title: "异常标签", value: "1,245", accent: "#d9a441" }
]

var riskCompanies = [
    { company: "海川智能制造有限公司", type: "背景异常", tags: 3, score: 86 },
    { company: "星河供应链管理有限公司", type: "涉税风险", tags: 2, score: 78 },
    { company: "长风科技服务有限公司", type: "经营异常", tags: 4, score: 91 },
    { company: "云岭贸易有限公司", type: "关联风险", tags: 1, score: 67 },
    { company: "启明数据科技有限公司", type: "舆情风险", tags: 2, score: 73 }
]

var abnormalTags = [
    { name: "法人关联企业过多", value: 63.25, color: "#4aa3df" },
    { name: "企业状态异常", value: 28.40, color: "#d65a4a" },
    { name: "营业期限临近", value: 18.70, color: "#d9a441" },
    { name: "税务非正常户", value: 12.05, color: "#67b26f" }
]

var centerSections = [
    "核心统计区域",
    "风险企业表格"
]

var footerText = "底部状态栏：Mock 数据已加载"