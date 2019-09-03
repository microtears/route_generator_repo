[![build_state](https://travis-ci.org/microtears/route_generator_repo.svg?branch=master)](https://travis-ci.org/microtears/route_generator_repo)&nbsp;&nbsp;

[English](https://github.com/microtears/route_generator_repo/blob/master/route_generator/README.md) [简体中文](https://github.com/microtears/route_generator_repo/blob/master/route_generator/README-CN.md)

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
- [从pubspec.yaml文件中的依赖包自动生成路由代码](#%e4%bb%8epubspecyaml%e6%96%87%e4%bb%b6%e4%b8%ad%e7%9a%84%e4%be%9d%e8%b5%96%e5%8c%85%e8%87%aa%e5%8a%a8%e7%94%9f%e6%88%90%e8%b7%af%e7%94%b1%e4%bb%a3%e7%a0%81)
- [关于build_runner watch模式下的问题](#%e5%85%b3%e4%ba%8ebuildrunner-watch%e6%a8%a1%e5%bc%8f%e4%b8%8b%e7%9a%84%e9%97%ae%e9%a2%98)
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
- 支持从pubspec.yaml文件中的依赖包自动生成路由代码

## 依赖

```yaml
dependencies:
  # Your other regular dependencies here
  route_annotation: ^0.2.0

dev_dependencies:
  # Your other dev_dependencies here
  build_runner: ^1.5.0
  route_generator: ^0.1.4
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
| `router` **new**                 | 与`Router()`相同                                                           |
| `page` **new**                   | 与`RoutePage()`相同                                                        |
| `initialPage` **new**            | 与`RoutePage(isInitialRoute: true)`相同                                    |
| `routeField` **new**             | 与`RouteField()`相同                                                       |
| `routeBuilder` **new**           | 与`PageRouteBuilderFuntcion()`相同                                         |
| `pageBuilder` **new**            | 与`RoutePageBuilderFunction()`相同                                         |
| `transitionBuilder` **new**      | 与`RouteTransitionBuilderFunction()`相同                                   |
| `transitionDuration` **new**     | 与`RouteTransitionDurationField()`相同                                     |

## 代码示例

### 定义路由 App

```dart
@router
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
@initialPage
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
@page
class CustomRoutePage extends StatelessWidget {
  @routeField
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
@page
class CustomRoutePage extends StatelessWidget {
  @pageBuilder
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
@page
class CustomRoutePage extends StatelessWidget {
  // pageBuilder注解表明这个方法用来定义如何返回RoutePage
  // 它是可选的
  @pageBuilder
  static Widget buildPage(BuildContext context, Animation animation,
          Animation secondaryAnimation, RouteSettings settings) =>
      CustomRoutePage();

  // transitionBuilder注解表明这个方法用来定义如何应用动画过渡
  // 它是可选的
  @transitionBuilder
  static Widget buildTransitions(
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
          RouteSettings settings) =>
      child;

  // transitionDuration注解表明这个字段用来定义页面过渡时常长，默认值为300 milliseconds
  // 它是可选的
  @transitionDuration
  static Duration transitionDurations = Duration(milliseconds: 400);

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

## 从pubspec.yaml文件中的依赖包自动生成路由代码

1. 在需要支持从pubspec.yaml文件中的依赖包自动生成路由代码的项目根目录下，新建build.yaml文件，如果已经存在，则跳过这一步。

2. 在文件中添加以下内容：

    ```yaml
    # If you are sure that you only run `flutter pub run build_runner build`,
    # and don't run `flutter pub run build_runner watch`, then you can enable
    # the following comment out content.
    # targets:
    #   $default:
    #     builders:
    #       route_generator|route_collector:
    #         enabled: false

    # If you also want to enable source code generation for the packages of
    # dependencies in the pubspec.yaml, I think the following is what you need.
    builders:
      route_collector_all_packages:
        import: 'package:route_generator/builder.dart'
        builder_factories: ['routeCollectorAllPackages']
        build_extensions: { '.dart': ['.collector_all_packages.dart'] }
        auto_apply: all_packages
        runs_before: ["route_generator|route_builder"]
        build_to: cache
    ```

    注意相同key部分请合并。

3. 重新运行build_runner command即可

获取更详细信息，请参阅[example](https://github.com/microtears/route_generator_repo/tree/master/example)

## 关于build_runner watch模式下的问题

- 需要了解的是：pubspec.yaml dependencies packages 不支持watch模式持续生成路由代码（第一次生成依然是有效的），但是你任然可以在当前的application启用watch模式。后期考虑支持。

- 由于BuildStep不支持同一文件的不同输出，即对于每一个文件，它的输出文件是限定了的，所以watch模式下，如果你修改了注解信息，那么你可能需要使Route注解所在的文件刷新一次(必须使文件出现改动，并且保存，例如添加空行)，才会重新生成xxx.route.dart。正在尽力解决，目前方案需要手动刷新一次，如果大家有更好的方案，欢迎提出。

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
import 'package:example_library/example_library.dart';
import 'package:example/custom_route_name_page.dart';
import 'package:example/custom_route_page.dart';
import 'package:example/home_page.dart';
import 'package:example/one_arguement_page.dart';
import 'package:example/two_arguement_page.dart';
import 'package:example/second_page.dart';

const ROUTE_LIBRARY_PAGE = 'library_page';
const ROUTE_CUSTOM = 'custom';
const ROUTE_CUSTOM_ROUTE_PAGE = 'custom_route_page';
const ROUTE_HOME = '/';
const ROUTE_ONE_ARGUMENT_PAGE = 'one_argument_page';
const ROUTE_TWO_ARGUMENT_PAGE = 'two_argument_page';
const ROUTE_SECOND_PAGE = 'second_page';

RouteFactory onGenerateRoute = (settings) => Map.fromEntries([
      ..._libraryPage.entries,
      ..._custom.entries,
      ..._customRoutePage.entries,
      ..._home.entries,
      ..._oneArgumentPage.entries,
      ..._twoArgumentPage.entries,
      ..._secondPage.entries,
    ])[settings.name](settings);

Map<String, RouteFactory> _libraryPage = <String, RouteFactory>{
  'library_page': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => LibraryPage(),
      ),
};
Map<String, RouteFactory> _custom = <String, RouteFactory>{
  'custom': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => CustomRoutePageName(),
      ),
};
Map<String, RouteFactory> _customRoutePage = CustomRoutePage.route;
Map<String, RouteFactory> _home = <String, RouteFactory>{
  '/': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => HomePage(),
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
        builder: (BuildContext context) {
          final arguments = settings.arguments as Map<String, dynamic>;
          return TwoArgumentPage(
            title: arguments['title'],
            subTitle: arguments['subTitle'],
          );
        },
      ),
};
Map<String, RouteFactory> _secondPage = <String, RouteFactory>{
  'second_page': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => SecondPage(),
      ),
};

```

## 常见问题

- 没有生成路由文件
  
  请检查是否添加了Router注解

- 路由生成不完整
  
  请尝试运行以下命令：
  - flutter pub run build_runner clean
  - flutter pub run build_runner build

## Example

获取更详细信息，请参阅[example](https://github.com/microtears/route_generator_repo/tree/master/example)
