[![build_state](https://travis-ci.org/microtears/route_generator_repo.svg?branch=master)](https://travis-ci.org/microtears/route_generator_repo)&nbsp;&nbsp;

[English](https://github.com/microtears/route_generator_repo/blob/master/route_generator/README.md) [简体中文](https://github.com/microtears/route_generator_repo/blob/master/route_generator/README-CN.md)

- [What is it](#what-is-it)
- [Features](#features)
- [Depend on it](#depend-on-it)
- [Running the code generation utility](#running-the-code-generation-utility)
- [route_annotation](#routeannotation)
- [Example code](#example-code)
  - [Define routing application](#define-routing-application)
  - [Define routing page](#define-routing-page)
  - [Define routing page parameters](#define-routing-page-parameters)
- [Custom route (priority: 3)](#custom-route-priority-3)
- [Custom route (priority: 2)](#custom-route-priority-2)
- [Custom route (priority: 1)](#custom-route-priority-1)
- [Automatically generate routing code from dependency packages in the pubspec.yaml file](#automatically-generate-routing-code-from-dependency-packages-in-the-pubspecyaml-file)
- [About the problem in build_runner watch mode](#about-the-problem-in-buildrunner-watch-mode)
- [Warning](#warning)
- [Generated code](#generated-code)
- [Common problem](#common-problem)

## What is it

This is a route generation library.Only a small amount of code is required,then use the annotation to match the source code generation, automatically generate the routing table.

## Features

- Custom route name.
- Custom route animations.
- Custom route parameters.
- Custom route logic.
- Automatically generate routing code from dependency packages in the pubspec.yaml file

## Depend on it

```yaml
dependencies:
  # Your other regular dependencies here
  route_annotation: ^0.2.0

dev_dependencies:
  # Your other dev_dependencies here
  build_runner: ^1.5.0
  route_generator: ^0.1.4
```

## Running the code generation utility

- One-time code generation

  By running `flutter pub run build_runner build` in the project root,you generate routing code for your application whenever they are needed. This triggers a one-time build that goes through the source files, picks the relevant ones, and generates the necessary routing code for them.

  While this is convenient, it would be nice if you did not have to run the build manually every time you make changes in your routing page classes.

- Generating code continuously

  A watcher makes our source code generation process more convenient. It watches changes in our project files and automatically builds the necessary files when needed. Start the watcher by running `flutter pub run build_runner watch` in the project root.

  It is safe to start the watcher once and leave it running in the background.

## route_annotation

| annotation                       | description                                                                                                                                 |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| `Router`                         | This annotation is used to mark a class that is a Flutter App and use this to generate the corresponding routing code.                      |
| `RoutePage`                      | This annotation is used to annotate a routing page                                                                                          |
| `RouteParameter`                 | An annotation used to mark page parameters is only designed for optional parameters. Used for `RoutePage`.                                  |
| `RouteField`                     | This annotation is used to mark a completely custom route, and the annotated object must be used as a static field of the route page class. |
| `PageRouteBuilderFuntcion`       | This annotation is used to identify the `RouteFactory` static method of a routing page.                                                     |
| `RoutePageBuilderFunction`       | This annotation is used to identify the `RoutePageBuilder` static  method of a routing page.                                                |
| `RouteTransitionBuilderFunction` | This annotation is used to identify the `TransitionBuilder` static method of a routing page.                                                |
| `RouteTransitionDurationField`   | This annotation is used to identify the transition time of a custom routing page.                                                           |
| `router` **new**                 | Same as `Router()`                                                                                                                          |
| `page` **new**                   | Same as `RoutePage()`                                                                                                                       |
| `initialPage` **new**            | Same as `RoutePage(isInitialRoute: true)`                                                                                                   |
| `routeField` **new**             | Same as `RouteField()`                                                                                                                      |
| `routeBuilder` **new**           | Same as `PageRouteBuilderFuntcion()`                                                                                                        |
| `pageBuilder` **new**            | Same as `RoutePageBuilderFunction()`                                                                                                        |
| `transitionBuilder` **new**      | Same as `RouteTransitionBuilderFunction()`                                                                                                  |
| `transitionDuration` **new**     | Same as `RouteTransitionDurationField()`                                                                                                    |

## Example code

### Define routing application

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

### Define routing page

```dart
@initialPage
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

```

### Define routing page parameters

- For single parameter

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

  Navigation:

  ```dart
  Navigator.of(context).pushNamed(
    ROUTE_ONE_ARGUMENT_PAGE,
    arguments: "title is empty",
  );
  ```
  
  Warning：
  
  For the route of a single parameter, the `arguments` is the raw argument when navigating with the Navigator.

- For multiple parameters

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

  Navigation:

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

  Warning：
  
  For the route of multiple parameters, the `arguments` must be `Map<string,dynamic>` when navigating with Navigator.

**If you don't need custom routing, the following sections, you can add nothing, let route_generator automatically generate relevant code for you!**

## Custom route (priority: 3)

This method has the highest priority for custom routing. If there are multiple custom routing options at the same time, this plan is selected first.

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

It will generate the following code:

```dart
Map<String, RouteFactory> _customRoutePage = CustomRoutePage.route;
```

## Custom route (priority: 2)

This method has a lower priority for custom routing. If there are multiple custom routing options at the same time, the plan is selected by priority from large to small.

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

It will generate the following code:

```dart
Map<String, RouteFactory> _customRoutePage = <String, RouteFactory>{
  'custom_route_page': CustomRoutePage.buildPageRoute,
};
```

## Custom route (priority: 1)

This method has the lowest priority for custom routing. If there are multiple custom routing options at the same time, the plan is selected by priority from large to small.

```dart
@page
class CustomRoutePage extends StatelessWidget {
  /// The pageBuilder annotation indicates that this method
  /// is used to define how to return a RoutePage.
  /// It is optional
  @pageBuilder
  static Widget buildPage(BuildContext context, Animation animation,
          Animation secondaryAnimation, RouteSettings settings) =>
      CustomRoutePage();

  /// The transitionBuilder annotation indicates that this
  /// method is used to define how to use animations.
  /// It is optional
  @transitionBuilder
  static Widget buildTransitions(
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
          RouteSettings settings) =>
      child;

  /// The transitionDuration annotation indicates that this
  /// field is used to define the length of the page transition. The
  /// default value is 300 milliseconds.
  /// It is optional
  @transitionDuration
  static Duration transitionDuration = Duration(milliseconds: 400);

  ...

}
```

It will generate the following code:

```dart
Map<String, RouteFactory> _customRoutePage = <String, RouteFactory>{
  'custom_route_page': (RouteSettings settings) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            CustomRoutePage.buildPage(
                context, animation, secondaryAnimation, settings),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            CustomRoutePage.buildTransitions(
                context, animation, secondaryAnimation, child, settings),
        transitionDuration: CustomRoutePage.transitionDurations,
      ),
};
```

## Automatically generate routing code from dependency packages in the pubspec.yaml file

1. In the project root directory that needs to support automatic generation of routing code from the dependencies in the pubspec.yaml file, create a new build.yaml file, skip this step if it already exists.

2. Add the following to the file:

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

    Note that the same key parts should be merged.

3. Re-run the build_runner command

For more details, please see [example](https://github.com/microtears/route_generator_repo/tree/master/example)

## About the problem in build_runner watch mode

- Need to know is: pubspec.yaml dependencies packages does not support watch mode to continuously generate routing code (the first generation is still valid), but you can still enable watch mode in the current application. Consider support later.

- Since BuildStep does not support different output of the same file, that is, for each file, its output file is limited, so in watch mode, if you modify the annotation information, then you may need to refresh the file where the Route annotation is located (The file must be changed and saved, such as adding a blank line), to regenerate xxx.route.dart. We are trying our best to solve it. The current plan needs to be refreshed manually. If you have a better solution, please feel free to ask.

## Warning

- Only one initalRoute is allowed
- initalRoute ignores custom route name,but generates a route name constant named `ROUTE_HOME`.
- All custom route methods or getters must be defined in the class of the route page and must be static and public.

## Generated code

The file name is filename.route.dart

Where filename is the file name of the Application class annotated by Router.

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

## Common problem

- No file generated
  
  Please check if the Router annotation has been added

- The generated route is incomplete
  
  Please try running the following command：
  - flutter pub run build_runner clean
  - flutter pub run build_runner build

For more details, please see [example](https://github.com/microtears/route_generator_repo/tree/master/example)
