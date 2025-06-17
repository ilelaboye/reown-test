import 'package:flutter/material.dart';
import 'package:reown_test/core/router.dart';

extension WidgetExtension on Widget {
  Widget onTap(VoidCallback action, {bool opaque = true}) {
    return GestureDetector(
      behavior: opaque ? HitTestBehavior.opaque : HitTestBehavior.deferToChild,
      onTap: action,
      child: this,
    );
  }
}

extension ContextExtension on BuildContext {
  Future<T?> push<T>(Widget page) =>
      Navigator.push<T>(this, PageRouter.fadeThrough(() => page));

  Future<T?> pushOff<T>(Widget page) => Navigator.pushAndRemoveUntil<T>(
      this, PageRouter.fadeThrough(() => page), (_) => false);

  void pop<T>([T? result]) => Navigator.of(this).pop(result);
}
