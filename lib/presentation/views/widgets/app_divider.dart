import 'package:flutter/material.dart';
import 'package:kabar/presentation/resources/colors.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.isHorizontal = true,
    this.thickness = 1,
    this.color,
  });

  final bool isHorizontal;
  final double thickness;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return isHorizontal
        ? Divider(
            height: thickness,
            color: color ?? AppColors.secondaryStrokeColor,
          )
        : VerticalDivider(
            width: thickness,
            color: color ?? AppColors.secondaryStrokeColor,
          );
  }
}
