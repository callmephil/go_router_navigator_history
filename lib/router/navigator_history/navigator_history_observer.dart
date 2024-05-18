import 'package:flutter/material.dart';
import 'package:go_router_bug_reports/router/navigator_history/navigator_history_model.dart';

class NavigatorHistoryObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    route.log('didPush');

    navigatorHistory.add(
      NavigatorHistory(
        name: route.settings.name!,
        arguments: route.settings.arguments as NavigatorHistoryArguments,
      ),
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    route.log('didPop');
    // _history.removeAt(_history.indexWhere(
    //   (e) => e.name == route.settings.name,
    // ));
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    route.log('didRemove');
    previousRoute?.log('didRemove previousRoute');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    newRoute?.log('newRoute');
    oldRoute?.log('newRoute previousRoute');
  }
}

extension on Route<dynamic> {
  void log(String method) {
    print('$method: name: ${settings.name}, arguments: ${settings.arguments}');
  }
}
