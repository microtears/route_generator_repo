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

## Depend on it

```yaml
dependencies:
  # Your other regular dependencies here
  route_annotation: ^0.1.0

dev_dependencies:
  # Your other dev_dependencies here
  build_runner: ^1.5.0
  route_generator: ^0.1.2
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

## Example code

### Define routing application

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

### Define routing page

```dart
// isInitialRoute is true to indicate that it will be used as the initial page
@RoutePage(isInitialRoute: true)
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

It will generate the following code:

```dart
Map<String, RouteFactory> _customRoutePage = CustomRoutePage.route;
```

## Custom route (priority: 2)

This method has a lower priority for custom routing. If there are multiple custom routing options at the same time, the plan is selected by priority from large to small.

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

It will generate the following code:

```dart
Map<String, RouteFactory> _customRoutePage = <String, RouteFactory>{
  'custom_route_page': CustomRoutePage.buildPageRoute,
};
```

## Custom route (priority: 1)

This method has the lowest priority for custom routing. If there are multiple custom routing options at the same time, the plan is selected by priority from large to small.

```dart
@RoutePage()
class CustomRoutePage extends StatelessWidget {
  /// The RoutePageBuilderFunction annotation indicates that this method
  /// is used to define how to return a RoutePage.
  /// It is optional
  @RoutePageBuilderFunction()
  static Widget buildPage(BuildContext context, Animation animation,
          Animation secondaryAnimation, RouteSettings settings) =>
      CustomRoutePage();

  /// The RouteTransitionBuilderFunction annotation indicates that this
  /// method is used to define how to use animations.
  /// It is optional
  @RouteTransitionBuilderFunction()
  static Widget buildTransitions(
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
          RouteSettings settings) =>
      child;

  /// The RouteTransitionDurationField annotation indicates that this
  /// field is used to define the length of the page transition. The
  /// default value is 300 milliseconds.
  /// It is optional
  @RouteTransitionDurationField()
  static Duration transitionDuration = Duration(milliseconds: 400);

  ...

}
```

It will generate the following code:

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

## Common problem

- No file generated
  
  Please check if the Router annotation has been added

For more details, please see [example](https://github.com/microtears/route_generator_repo/tree/master/example)
