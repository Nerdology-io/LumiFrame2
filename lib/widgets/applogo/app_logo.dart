import 'package:flutter/material.dart';
import 'logo_animation.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool animated;

  const AppLogo({
    super.key,
    this.size = 100.0,
    this.animated = true,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: animated
          ? LogoAnimation(size: size)
          : Icon(Icons.photo, size: size, color: Theme.of(context).primaryColor),
    );
  }
}