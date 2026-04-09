import 'dart:async';

import 'package:flutter/material.dart';

class StaggerReveal extends StatefulWidget {
  const StaggerReveal({
    super.key,
    required this.child,
    this.index = 0,
    this.delayStepMs = 70,
    this.offsetY = 0.06,
    this.duration = const Duration(milliseconds: 420),
  });

  final Widget child;
  final int index;
  final int delayStepMs;
  final double offsetY;
  final Duration duration;

  @override
  State<StaggerReveal> createState() => _StaggerRevealState();
}

class _StaggerRevealState extends State<StaggerReveal> {
  bool _visible = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    final int delay = widget.index * widget.delayStepMs;
    _timer = Timer(Duration(milliseconds: delay), () {
      if (!mounted) {
        return;
      }
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: _visible ? Offset.zero : Offset(0, widget.offsetY),
      duration: widget.duration,
      curve: Curves.easeOutCubic,
      child: AnimatedOpacity(
        opacity: _visible ? 1 : 0,
        duration: widget.duration,
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}
