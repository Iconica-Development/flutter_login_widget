import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomNavigator extends StatefulWidget {
  const CustomNavigator({
    required this.home,
    Key? key,
    this.navigatorKey,
    this.initialRoute,
    this.onGenerateRoute,
    this.routes = const <String, WidgetBuilder>{},
    this.pageRoute,
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
  }) : super(key: key);

  final GlobalKey<NavigatorState>? navigatorKey;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;
  final Map<String, WidgetBuilder> routes;
  final PageRouteFactory? pageRoute;
  final Widget home;
  final RouteFactory? onUnknownRoute;
  final List<NavigatorObserver> navigatorObservers;

  @override
  _CustomNavigatorState createState() => _CustomNavigatorState();
}

class _CustomNavigatorState extends State<CustomNavigator>
    implements WidgetsBindingObserver {
  GlobalKey<NavigatorState>? _navigator;

  void _setNavigator() =>
      _navigator = widget.navigatorKey ?? GlobalObjectKey<NavigatorState>(this);

  @override
  void initState() {
    _setNavigator();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeMetrics() {}

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigator,
      initialRoute: WidgetsBinding.instance.window.defaultRouteName !=
              Navigator.defaultRouteName
          ? WidgetsBinding.instance.window.defaultRouteName
          : widget.initialRoute ??
              WidgetsBinding.instance.window.defaultRouteName,
      onGenerateRoute: _onGenerateRoute,
      onUnknownRoute: _onUnknownRoute,
      observers: widget.navigatorObservers,
    );
  }

  @override
  Future<bool> didPopRoute() async {
    assert(mounted);
    var navigator = _navigator?.currentState;
    if (navigator == null) {
      return false;
    }
    return navigator.maybePop();
  }

  @override
  Future<bool> didPushRoute(String route) async {
    assert(mounted);
    var navigator = _navigator?.currentState;
    if (navigator == null) {
      return false;
    }
    await navigator.pushNamed(route);
    return true;
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    var name = settings.name;
    var pageContentBuilder = name == Navigator.defaultRouteName
        ? (BuildContext context) => widget.home
        : widget.routes[name!];

    if (pageContentBuilder != null) {
      assert(
          widget.pageRoute != null,
          'The default onGenerateRoute handler for CustomNavigator must have a '
          'pageRoute set if the home or routes properties are set.');
      Route<dynamic> route = widget.pageRoute!<dynamic>(
        settings,
        pageContentBuilder,
      );
      return route;
    }

    if (widget.onGenerateRoute != null) {
      return widget.onGenerateRoute!(settings);
    }

    return null;
  }

  Route<dynamic>? _onUnknownRoute(RouteSettings settings) {
    assert(() {
      if (widget.onUnknownRoute == null) {
        throw FlutterError(
            'Could not find a generator for route $settings in the $runtimeType.\n'
            'Generators for routes are searched for in the following order:\n'
            ' 1. For the "/" route, the "home" property, if non-null, is used.\n'
            ' 2. Otherwise, the "routes" table is used, if it has an entry for '
            'the route.\n'
            ' 3. Otherwise, onGenerateRoute is called. It should return a '
            'non-null value for any valid route not handled by "home" and "routes".\n'
            ' 4. Finally if all else fails onUnknownRoute is called.\n'
            'Unfortunately, onUnknownRoute was not set.');
      }
      return true;
    }());
    final Route<dynamic>? result = widget.onUnknownRoute!(settings);
    assert(() {
      if (result == null) {
        throw FlutterError('The onUnknownRoute callback returned null.\n'
            'When the $runtimeType requested the route $settings from its '
            'onUnknownRoute callback, the callback returned null. Such callbacks '
            'must never return null.');
      }
      return true;
    }());
    return result;
  }

  didChangeAppLifecycleState(AppLifecycleState state) {}

  noSuchMethod(Invocation invocation) {
    var name = invocation.memberName.toString();
    debugPrint(
      'Expected a method to be called with name $name, '
      'but no such method was found.',
    );
  }
}

class PageRoutes {
  static final materialPageRoute =
      (<T>(RouteSettings settings, WidgetBuilder builder) =>
          MaterialPageRoute<T>(settings: settings, builder: builder));
  static final cupertinoPageRoute =
      (<T>(RouteSettings settings, WidgetBuilder builder) =>
          CupertinoPageRoute<T>(settings: settings, builder: builder));
}
