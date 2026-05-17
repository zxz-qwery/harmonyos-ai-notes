# 🚀 HarmonyOS AI Notes

基于 HarmonyOS NEXT + ArkTS 开发的 AI 智能便签应用。

本项目用于演练 HarmonyOS 应用开发、ArkTS 页面开发、组件化设计、Git Flow 协作流程以及 AI 接口调用能力。

------

# 📱 项目介绍

HarmonyOS AI Notes 是一款简洁风格的智能便签应用。

当前版本已完成：

- 首页 UI 开发
- 新建便签页面
- 页面跳转
- Mock 数据展示
- Git Flow 分支管理演练

后续将逐步接入 AI 摘要、情绪分析、本地存储等功能。

------

# 🛠 技术栈

- HarmonyOS NEXT
- ArkTS
- DevEco Studio
- ArkUI
- Git / Git Flow

------

# 📂 项目结构

```bash
entry/src/main/ets
│
├── pages
│   ├── Index.ets
│   └── CreateNote.ets
│
├── components
│
├── service
│
└── utils
```

------

# ✨ 当前功能

## 首页

- 便签列表展示
- 情绪标签展示
- 悬浮新增按钮
- 页面滚动

## 新建页面

- 标题输入
- 内容输入
- AI 摘要按钮（UI）
- 保存按钮（UI）

## 页面跳转

- 首页跳转新建页

------

# 📸 页面展示

## 首页

（这里放首页截图）

## 新建页

（这里放新建页截图）

------

# 🔀 Git Flow 演练

当前使用 Git Flow 进行分支管理：

```bash
main
develop
feature/day1-ui
```

开发流程：

```bash
feature → develop → main
```

------

# 📅 开发计划

## Day1

-  创建鸿蒙项目
-  首页 UI
-  新建页面 UI
-  页面跳转

## Day2

-  本地存储
-  新增便签
-  删除便签
-  数据管理

## Day3

-  AI 摘要功能
-  网络请求封装
-  AI 情绪分析

## Day4

-  项目优化
-  README 完善
-  项目部署与展示

------

# 📚 Day1 开发收获

通过 Day1 的开发，完成了 HarmonyOS 项目的基础搭建，并熟悉了 ArkTS 页面开发方式。

学习内容包括：

- ArkUI 页面布局
- Column / Row / List 使用
- @State 状态管理
- 页面跳转 router.pushUrl
- 基础组件化思想
- Git Flow 分支开发流程

同时体验了使用 Trae AI 辅助 HarmonyOS 页面开发的流程，提高了 UI 开发效率。

------

# 🎯 项目目标

通过本项目逐步掌握：

- HarmonyOS NEXT 应用开发
- ArkTS 组件化开发
- 鸿蒙网络请求
- 本地存储
- AI 接口调用
- 企业级 Git 协作流程

------