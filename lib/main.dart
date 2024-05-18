import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_bug_reports/router/router.dart';

final _navKey = GlobalKey<NavigatorState>();

void main() {
  usePathUrlStrategy();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: GoRouter(
        observers: [NavigatorHistoryObserver()],
        navigatorKey: _navKey,
        // debugLogDiagnostics: true,
        routerNeglect: true,
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            pageBuilder: (context, state) {
              return FadeTransitionPage(
                state: state,
                child: const ParentScreen(),
              );
            },
            routes: [
              GoRoute(
                path: 'content/:id',
                name: 'child',
                pageBuilder: (context, state) {
                  return FadeTransitionPage(
                    state: state,
                    child: const ChildScreen(),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/third',
            name: 'third',
            pageBuilder: (context, state) {
              return FadeTransitionPage(
                state: state,
                child: const ThirdScreen(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ParentScreen extends StatefulWidget {
  const ParentScreen({super.key});

  @override
  State<ParentScreen> createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  @override
  Widget build(BuildContext context) {
    // _history.log();
    // This print statement is being called if the child screen is opened.
    print('parent screen has been built');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Parent Screen'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            if (navigatorHistory.indexWhere((e) => e.name == 'child') != -1) {
              navigatorHistory.removeWhere((e) => e.name == 'child');
            }

            context.goNamed(
              'child',
              pathParameters: {'id': '1'},
              queryParameters: {'name': 'John'},
            );
          },
          child: const Text('Go to child screen'),
        ),
      ),
    );
  }
}

class ChildScreen extends StatelessWidget {
  const ChildScreen({super.key});

  @override
  Widget build(BuildContext context) {
    navigatorHistory.log();
    print('child screen has been built');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Child Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                print(navigatorHistory.length);

                context.popHistory();
              },
              child: const Text('Go To Previous Screen'),
            ),
            TextButton(
              onPressed: () {
                context.goNamed('third');
              },
              child: const Text('Go to third Screen'),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('third has been built');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Screen'),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                context.goNamed(
                  'child',
                  pathParameters: {'id': '1'},
                  queryParameters: {'name': 'John'},
                );
              },
              child: const Text('Go to content screen'),
            ),
            TextButton(
              onPressed: () {
                print(navigatorHistory.length);

                // if (navigatorHistory.length == 1) {
                //   print('call 1');
                //   if (navigatorHistory.first.name != 'home') {
                //     print('call');
                //     context.goNamed('home');
                //     return;
                //   }
                // }

                context.popHistory();
              },
              child: const Text('Go to previous screen'),
            ),
          ],
        ),
      ),
    );
  }
}
