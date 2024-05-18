import 'package:flutter/foundation.dart';

final navigatorHistory = <NavigatorHistory>[];
typedef NavigatorHistoryArguments = Map<String, Map<String, String>>;

class NavigatorHistory {
  final String name;
  final NavigatorHistoryArguments arguments;

  const NavigatorHistory({
    required this.name,
    required this.arguments,
  });

  Map<String, String> get pathParameters {
    return arguments['pathParameters'] ?? {};
  }

  Map<String, String> get queryParameters {
    return arguments['queryParameters'] ?? {};
  }

  @override
  String toString() {
    return 'NavigatorHistory(name: $name, arguments: $arguments)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NavigatorHistory &&
        other.name == name &&
        mapEquals(other.arguments, arguments);
  }

  @override
  int get hashCode => name.hashCode ^ arguments.hashCode;

  NavigatorHistory copyWith({
    String? name,
    NavigatorHistoryArguments? arguments,
  }) {
    return NavigatorHistory(
      name: name ?? this.name,
      arguments: arguments ?? this.arguments,
    );
  }

  factory NavigatorHistory.fromMap(Map<String, dynamic> map) {
    return NavigatorHistory(
      name: map['name'],
      arguments: Map<String, Map<String, String>>.from(map['arguments']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'arguments': arguments,
    };
  }
}
