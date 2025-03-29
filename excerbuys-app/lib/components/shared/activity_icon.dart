import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActivityIcon extends StatelessWidget {
  final String icon;
  final double size;
  const ActivityIcon({super.key, required this.icon, required this.size});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      height: size,
      width: size,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100), color: colors.secondary),
      child: Center(
        child: SizedBox(
          width: size / 2,
          height: size / 2,
          child: SvgPicture.asset(icon,
              colorFilter: ColorFilter.mode(colors.primary, BlendMode.srcIn)),
        ),
      ),
    );
  }
}
