import 'package:animai/src/features/navigation/domain/models/navigation_item.dart';
import 'package:flutter/material.dart';

/// Configuration for navigation screens with builder patterns
class NavigationConfig {
  final Widget Function() builder;
  final NavigationItem item;
  final bool maintainState;

  const NavigationConfig({
    required this.builder,
    required this.item,
    this.maintainState = true,
  });
}
