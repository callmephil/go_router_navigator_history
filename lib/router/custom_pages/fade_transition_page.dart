// CustomPage FadeTransition
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FadeTransitionPage extends CustomTransitionPage<void> {
  /// Creates a [FadeTransitionPage].
  final GoRouterState state;
  FadeTransitionPage({
    required this.state,
    required super.child,
    super.restorationId,
    super.transitionDuration = const Duration(milliseconds: 300),
    super.reverseTransitionDuration = const Duration(milliseconds: 300),
    super.maintainState = true,
    super.fullscreenDialog = false,
    super.opaque = true,
    super.barrierDismissible = false,
    super.barrierColor,
    super.barrierLabel,
  }) : super(
          key: state.pageKey,
          name: state.name ?? state.path ?? '',
          arguments: getArguments(state),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return FadeTransition(
              alwaysIncludeSemantics: true,
              opacity: animation.drive(_curveTween),
              child: child,
            );
          },
        );

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeIn);

  static Map<String, Map<String, String>> getArguments(GoRouterState state) {
    var args = <String, Map<String, String>>{};

    print('state.path ${state.path}');
    print('state.uri ${state.uri}');
    print('state.uri.queryParameters: ${state.uri.queryParameters}');
    print('state.pathParameters: ${state.pathParameters}');

    if (state.uri.queryParameters.isNotEmpty) {
      args['queryParameters'] = state.uri.queryParameters;
    }

    if (state.path?.contains(':') ?? false) {
      args['pathParameters'] = state.pathParameters;
    }

    return args;
  }
}
