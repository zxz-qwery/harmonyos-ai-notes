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
- ✅ 本地存储
- ✅ 新增删除
- ✅ 数据持久化
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

# 📚 Day2 开发收获

通过 Day2 的开发，补齐了便签应用最核心的数据能力：本地存储、增删操作与数据持久化，并完成页面返回后的自动刷新体验。

学习内容包括：

- 使用 @ohos.data.preferences 进行本地存储
- NoteModel 数据类型抽象与类型约束
- StorageService 封装 saveNotes / getNotes / deleteNote
- JSON.stringify / JSON.parse 的序列化与反序列化
- async/await 异步读写与页面状态刷新
- 新建便签写入本地、返回首页自动刷新列表
- 删除便签同步更新本地存储与 UI

------

# 🚀 Day3 开发记录（AI 功能接入）

## ✅ 今日完成

- 完成 HarmonyOS 网络请求封装
- 完成 HttpUtil 工具类
- 完成 AiService 服务层封装
- 完成 Laravel Mock AI 接口
- 完成 AI 摘要功能
- 完成 AI 情绪分析功能
- 完成 HarmonyOS 与 Laravel 前后端联调
- 完成 JSON 数据解析与页面更新

------

## 🧠 AI 功能实现

### AI 摘要

用户输入便签内容后：

- 点击 “AI生成摘要”
- HarmonyOS 调用 Laravel AI 接口
- 后端返回 summary
- 自动生成便签标题

示例：

输入：

今天学习了 HarmonyOS 网络请求与本地存储开发。

输出：

HarmonyOS开发学习总结

------

### AI 情绪分析

根据用户输入内容：

自动分析当前情绪：

- positive 😊
- negative 😔

并在首页动态展示不同情绪状态。

------

## 🌐 技术实现

### HarmonyOS

- ArkTS
- @ohos.net.http
- @State 状态管理
- 页面路由
- Preferences 本地存储

### Laravel

- API 接口开发
- JSON 数据返回
- Mock AI 接口
- RESTful 风格接口

------

## 📂 项目结构优化

新增：

- utils/HttpUtil.ets
- service/AiService.ets

实现：

- 网络请求封装
- Service 层解耦
- 模块化开发

------

## 🛠 今日遇到的问题

### 1. 网络请求失败

原因：

HarmonyOS 模拟器无法直接访问 localhost。

解决：

使用：

[http://10.0.2.2:8000](http://10.0.2.2:8000/)

访问宿主机 Laravel 服务。

------

### 2. JSON 解析问题

原因：

接口返回结构不一致。

解决：

统一 Laravel 返回 JSON 格式。

------

### 3. trim 报错

原因：

输入框内容可能为 undefined。

解决：

增加默认值与空值保护。

------

## 🎯 今日开发收获

通过 Day3 的开发：

第一次完整体验了：

- AI 接口调用
- HarmonyOS 与 Laravel 联调
- HTTP 网络请求
- JSON 数据解析
- AI 增强交互
- Service 层封装

项目从普通便签应用：

升级为：

AI 增强型便签应用！

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
