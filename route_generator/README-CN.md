[English](README.md) [简体中文](README-CN.md)

- [route_generator是什么](#routegenerator%e6%98%af%e4%bb%80%e4%b9%88)
- [特性](#%e7%89%b9%e6%80%a7)
- [依赖](#%e4%be%9d%e8%b5%96)
- [生成代码](#%e7%94%9f%e6%88%90%e4%bb%a3%e7%a0%81)
- [route_annotation](#routeannotation)
- [代码示例](#%e4%bb%a3%e7%a0%81%e7%a4%ba%e4%be%8b)
  - [定义路由 App](#%e5%ae%9a%e4%b9%89%e8%b7%af%e7%94%b1-app)
  - [定义路由页面](#%e5%ae%9a%e4%b9%89%e8%b7%af%e7%94%b1%e9%a1%b5%e9%9d%a2)
  - [定义路由页面参数](#%e5%ae%9a%e4%b9%89%e8%b7%af%e7%94%b1%e9%a1%b5%e9%9d%a2%e5%8f%82%e6%95%b0)
- [自定义路由（优先级：3）](#%e8%87%aa%e5%ae%9a%e4%b9%89%e8%b7%af%e7%94%b1%e4%bc%98%e5%85%88%e7%ba%a73)
- [自定义路由（优先级：2）](#%e8%87%aa%e5%ae%9a%e4%b9%89%e8%b7%af%e7%94%b1%e4%bc%98%e5%85%88%e7%ba%a72)
- [自定义路由（优先级：1）](#%e8%87%aa%e5%ae%9a%e4%b9%89%e8%b7%af%e7%94%b1%e4%bc%98%e5%85%88%e7%ba%a71)
- [注意事项](#%e6%b3%a8%e6%84%8f%e4%ba%8b%e9%a1%b9)
- [最终生成代码](#%e6%9c%80%e7%bb%88%e7%94%9f%e6%88%90%e4%bb%a3%e7%a0%81)
- [常见问题](#%e5%b8%b8%e8%a7%81%e9%97%ae%e9%a2%98)
- [Example](#example)

## route_generator是什么

这是一个简单的 Flutter 路由生成库，只需要少量的代码，然后利用注解配合源代码生成，自动生成路由表，省去手工管理路由代码的烦恼。

## 特性

- 自定义路由名称
- 自定义路由动画
- 自定义路由参数
- 自定义路由逻辑

## 依赖

```yaml
dependencies:
  # Your other regular dependencies here
  route_annotation: ^0.1.0

dev_dependencies:
  # Your other dev_dependencies here
  build_runner: ^1.5.0
  route_generator: ^0.1.2
```

## 生成代码

- 单次构建

  在项目根目录中运行`flutter pub run build_runner build`，可以在需要时为项目生成路由代码。这会触发一次性构建，该构建遍历源文件，选择相关文件，并为它们生成必要的路由代码。虽然这很方便，但如果您不必每次在模型类中进行更改时都必须手动构建，那么你可以选择持续构建。

- 持续构建

  在项目根目录中运行`flutter pub run build_runner watch`来启动watcher，它可以使我们的源代码生成过程更加方便。它会监视项目文件中的更改，并在需要时自动构建必要的文件。

## route_annotation

| annotation                       | description                                                                |
| -------------------------------- | -------------------------------------------------------------------------- |
| `Router`                         | 此注解用来标志某个为 Flutter App 的类，并以此生成相应的路由代码            |
| `RoutePage`                      | 此注解用来注解一个路由页面                                                 |
| `RouteParameter`                 | 一个用来标志页面参数的注解，只为可选参数设计。用于 `RoutePage` 。          |
| `RouteField`                     | 此注解用来标志一个完全自定义的路由，被注解的对象必须作为路由页面类静态字段 |
| `PageRouteBuilderFuntcion`       | 这个注解用来标识一个路由页面的 `RouteFactory` 静态方法                     |
| `RoutePageBuilderFunction`       | 这个注解用来标识一个路由页面的 `RoutePageBuilder`静态方法                  |
| `RouteTransitionBuilderFunction` | 这个注解用来标识一个路由页面的 `TransitionBuilder` 静态方法                |
| `RouteTransitionDurationField`   | 这个注解用来标识一个自定义路由页面的过渡时长                               |

## 代码示例

### 定义路由 App

```dart
@Router()
class DemoApp extends StatefulWidget {
  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      onGenerateRoute: onGenerateRoute,
    );
  }
}
```

### 定义路由页面

```dart
// isInitialRoute为true表示它将作为initial page
@RoutePage(isInitialRoute: true)
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

```

### 定义路由页面参数

- 对于单个参数

  ```dart
  @RoutePage(params: [RouteParameter("title")])
  class OneArgumentPage extends StatelessWidget {
    final String title;

    const OneArgumentPage({Key key, this.title}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Container();
    }
  }
  ```

  导航

  ```dart
  Navigator.of(context).pushNamed(
    ROUTE_ONE_ARGUMENT_PAGE,
    arguments: "title is empty",
  );
  ```
  
  注意事项：
  
  对于单个参数的路由，利用Navigator进行导航的时候`arguments`即为原始参数。

- 对于多个参数

  ```dart
  @RoutePage(params: [RouteParameter("title"), RouteParameter("subTitle")])
  class TwoArgumentPage extends StatelessWidget {
    final String title;
    final String subTitle;

    TwoArgumentPage({this.title, Key key, this.subTitle}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Scaffold();
    }
  }
  ```

  导航

  ```dart
  Navigator.of(context).pushNamed(
    ROUTE_TWO_ARGUMENT_PAGE,
    arguments: {
      "title": _titleController.text.isNotEmpty
          ? _titleController.text
          : "title is empty",
      "subTitle": _subTitleController.text.isNotEmpty
          ? _subTitleController.text
          : "sub title is empty",
    },
  );
  ```

  注意事项：
  
  对于多个参数的路由，利用Navigator进行导航的时候`arguments`必须为`Map<string,dynamic>`。

**如果你不需要自定义路由，以下部分，你可以什么都不用添加，就让route_generator为你自动生成相关代码吧！**

## 自定义路由（优先级：3）

这种方法自定义路由的优先级最高，如果同时存在多种自定义路由选择，该种方案最先被选择。

```dart
@RoutePage()
class CustomRoutePage extends StatelessWidget {
  @RouteField()
  static Map<String, RouteFactory> route = <String, RouteFactory>{
    'custom_route': (RouteSettings settings) =>
        MaterialPageRoute(builder: (BuildContext context) => CustomRoutePage()),
    'alias_route': (RouteSettings settings) => PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation animation,
                  Animation secondaryAnimation) =>
              CustomRoutePage(),
        ),
  };

  ...

}
```

它会生成如下代码：

```dart
Map<String, RouteFactory> _customRoutePage = CustomRoutePage.route;
```

## 自定义路由（优先级：2）

这种方法自定义路由的优先级较低，如果同时存在多种自定义路由选择，则按优先级从大到小选择。

```dart
@RoutePage()
class CustomRoutePage extends StatelessWidget {
  @PageRouteBuilderFuntcion()
  static Route buildPageRoute(RouteSettings settings) => PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation animation,
                Animation secondaryAnimation) =>
            CustomRoutePage(),
      );

  ...

}
```

它会生成如下代码：

```dart
Map<String, RouteFactory> _customRoutePage = <String, RouteFactory>{
  'custom_route_page': CustomRoutePage.buildPageRoute,
};
```

## 自定义路由（优先级：1）

这种方法自定义路由的优先级最低，如果同时存在多种自定义路由选择，则按优先级从大到小选择。

```dart
@RoutePage()
class CustomRoutePage extends StatelessWidget {
  // RoutePageBuilderFunction注解表明这个方法用来定义如何返回RoutePage
  // 它是可选的
  @RoutePageBuilderFunction()
  static Widget buildPage(BuildContext context, Animation animation,
          Animation secondaryAnimation, RouteSettings settings) =>
      CustomRoutePage();

  // RouteTransitionBuilderFunction注解表明这个方法用来定义如何应用动画过渡
  // 它是可选的
  @RouteTransitionBuilderFunction()
  static Widget buildTransitions(
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
          RouteSettings settings) =>
      child;

  // RouteTransitionDurationField注解表明这个字段用来定义页面过渡时常长，默认值为300 milliseconds
  // 它是可选的
  @RouteTransitionDurationField()
  static Duration transitionDuration = Duration(milliseconds: 400);

  ...

}
```

它会生成如下代码：

```dart
Map<String, RouteFactory> _customRoutePage = <String, RouteFactory>{
  'custom_route_page': (RouteSettings settings) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            CustomRoutePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            CustomRoutePage.buildTransitions(
                context, animation, secondaryAnimation, child, settings),
        transitionDuration: CustomRoutePage.transitionDuration,
      ),
};
```

## 注意事项

- 只允许有一个initalRoute
- initalRoute会忽略自定义路由名，但会生成名为`ROUTE_HOME`的路由名称常量。
- 所有自定义路由method或getter必须定义在路由所在类，且必须为static所修饰的和非私有的。

## 最终生成代码

最终生成的文件名为FILENAME.route.dart
其中FILENAME是被Router注解的App类所在的文件名。

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// RouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'home_page.dart';
import 'custom_route_page.dart';
import 'custom_route_name_page.dart';
import 'second_page.dart';
import 'one_arguement_page.dart';
import 'two_arguement_page.dart';

const ROUTE_HOME = '/';
const ROUTE_CUSTOM_ROUTE_PAGE = 'custom_route_page';
const ROUTE_CUSTOM = 'custom';
const ROUTE_SECOND_PAGE = 'second_page';
const ROUTE_ONE_ARGUMENT_PAGE = 'one_argument_page';
const ROUTE_TWO_ARGUMENT_PAGE = 'two_argument_page';

RouteFactory onGenerateRoute = (settings) => Map.fromEntries([
      ..._home.entries,
      ..._customRoutePage.entries,
      ..._custom.entries,
      ..._secondPage.entries,
      ..._oneArgumentPage.entries,
      ..._twoArgumentPage.entries,
    ])[settings.name](settings);

Map<String, RouteFactory> _home = <String, RouteFactory>{
  '/': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => HomePage(),
      ),
};
Map<String, RouteFactory> _customRoutePage = <String, RouteFactory>{
  'custom_route_page': (RouteSettings settings) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            CustomRoutePage.buildPage(
                context, animation, secondaryAnimation, settings),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            CustomRoutePage.buildTransitions(
                context, animation, secondaryAnimation, child, settings),
        transitionDuration: CustomRoutePage.transitionDuration,
      ),
};
Map<String, RouteFactory> _custom = <String, RouteFactory>{
  'custom': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => CustomRoutePageName(),
      ),
};
Map<String, RouteFactory> _secondPage = <String, RouteFactory>{
  'second_page': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => SecondPage(),
      ),
};
Map<String, RouteFactory> _oneArgumentPage = <String, RouteFactory>{
  'one_argument_page': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) =>
            OneArgumentPage(title: settings.arguments),
      ),
};
Map<String, RouteFactory> _twoArgumentPage = <String, RouteFactory>{
  'two_argument_page': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => TwoArgumentPage(
              title: (settings.arguments as Map<String, dynamic>)['title'],
              subTitle:
                  (settings.arguments as Map<String, dynamic>)['subTitle'],
            ),
      ),
};

```

## 常见问题

- 没有生成路由文件
  
  请检查是否添加了Router注解

## Example

获取更详细信息，请参阅[example](https://github.com/microtears/route_generator_repo/tree/master/example)
