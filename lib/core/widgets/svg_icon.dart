import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSvgIcon extends StatelessWidget {
  final String assetPath;
  final double size;
  final Color? color;
  final BoxFit? fit;

  const AppSvgIcon(this.assetPath, {super.key, this.size = 24, this.color, this.fit});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(
        color ?? IconTheme.of(context).color ?? Colors.black,
        BlendMode.srcIn,
      ),
      fit: fit?? fit ?? BoxFit.contain,
    );
  }
}
