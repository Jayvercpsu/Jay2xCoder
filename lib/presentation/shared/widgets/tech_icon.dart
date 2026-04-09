import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TechIcon extends StatelessWidget {
  const TechIcon({super.key, required this.asset, this.size = 24});

  final String asset;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
