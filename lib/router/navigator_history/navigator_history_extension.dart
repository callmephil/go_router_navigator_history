import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_bug_reports/router/navigator_history/navigator_history_model.dart';

extension NavigatorHistoryListExtension on List<NavigatorHistory> {
  NavigatorHistory get previous {
    return length > 1 ? this[length - 2] : this[0];
  }

  void log() {
    print(this);
    // for (final history in this) {
    //   print(
    //     'historyLog: name: ${history.name}, arguments: ${history.arguments}',
    //   );
    // }
  }
}

extension GoRouterNavigatorHistoryExtension on BuildContext {
  void clearAndPopHistory() {
    Router.neglect(this, () {
      popHistory();
      navigatorHistory.clear();
    });
  }

  void popHistory() {
    // TODO: figure out the initial route name dynamically
    if (navigatorHistory.length == 1) {
      if (navigatorHistory.first.name != 'home') {
        goNamed('home');
        return;
      }
    }

    final history = navigatorHistory.previous;

    goNamed(
      history.name,
      pathParameters: history.pathParameters,
      queryParameters: history.queryParameters,
    );
  }

  //
}
