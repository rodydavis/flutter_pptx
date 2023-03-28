import 'package:flutter/material.dart';

class BaseWidget extends StatelessWidget {
  const BaseWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: child,
    );
  }
}
