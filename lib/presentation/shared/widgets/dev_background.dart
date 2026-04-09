import 'package:flutter/material.dart';
import 'package:jay2xcoder/presentation/shared/widgets/reference_kit.dart';

class DevBackground extends StatelessWidget {
  const DevBackground({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ReferenceBackground(child: child);
  }
}
