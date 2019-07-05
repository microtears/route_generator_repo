# **route_generator**

## 一个简单的Flutter路由生成库，通过注解配合源代码生成，减去手工管理路由代码的烦恼

## 支持自定义路由名称，支持自定义路由动画，支持自定义路由参数，允许创建别名

## Todo

- [ ] 参数默认值（功能尚不稳定）
- [ ] 生成可以静态检查参数的路由常量
- [ ] 完善Demo Application
- [ ] 补充样例
- [ ] 支持build runner watch mode

## 生成代码

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// RouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:task_app/app/upload/upload_comment.dart';
import 'package:task_app/app/upload/upload_list.dart';
import 'package:task_app/app/upload/upload_page.dart';

RouteFactory onGenerateRoute = (settings) => Map.fromEntries([
      ..._commentEditPage.entries,
      ..._home.entries,
      ..._uploadPage.entries,
    ])[settings.name](settings);

Map<String, RouteFactory> _commentEditPage = <String, RouteFactory>{
  'comment_edit_page': (RouteSettings settings) =>
      MaterialPageRoute(builder: (BuildContext context) => CommentEditPage())
};
Map<String, RouteFactory> _home = <String, RouteFactory>{
  '/': (RouteSettings settings) =>
      MaterialPageRoute(builder: (BuildContext context) => UploadListPage())
};
Map<String, RouteFactory> _uploadPage = <String, RouteFactory>{
  'upload_page': (RouteSettings settings) =>
      MaterialPageRoute(builder: (BuildContext context) => UploadPage())
};

const ROUTE_COMMENT_EDIT_PAGE = 'comment_edit_page';
const ROUTE_HOME = '/';
const ROUTE_UPLOAD_PAGE = 'upload_page';

```
