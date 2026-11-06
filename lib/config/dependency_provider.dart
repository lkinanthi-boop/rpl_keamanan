import 'package:flutter/material.dart';

import '../repositories/user_repository.dart';
import '../repositories/post_repository.dart';

class DependencyProvider extends InheritedWidget {
  final UserRepository userRepository;
  final PostRepository postRepository;

  const DependencyProvider({
    super.key,
    required this.userRepository,
    required this.postRepository,
    required super.child,
  });

  static DependencyProvider of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<DependencyProvider>();

    assert(provider != null, 'DependencyProvider tidak ditemukan');
    return provider!;
  }

  @override
  bool updateShouldNotify(DependencyProvider oldWidget) {
    return userRepository != oldWidget.userRepository ||
        postRepository != oldWidget.postRepository;
  }
}
