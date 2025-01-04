import 'package:autro_app/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ShowIconButton extends StatelessWidget {
  const ShowIconButton({super.key, this.onPressed});
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: SvgPicture.asset(Assets.iconsEye),
      style: const ButtonStyle(
        padding: WidgetStatePropertyAll(EdgeInsets.all(3)),
      ),
      constraints: const BoxConstraints(minWidth: 0, minHeight: 0),
    );
  }
}
