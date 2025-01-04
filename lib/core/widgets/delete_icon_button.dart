import 'package:autro_app/constants/assets.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DeleteIconButton extends StatelessWidget {
  const DeleteIconButton({super.key, this.onPressed});
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed != null
          ? () async {
              final isOk = await DialogUtil.showAlertDialog(
                    context,
                    title: 'Delete',
                    content: 'Are you sure you want to delete this item?',
                  ) ??
                  false;
              if (isOk) {
                onPressed!();
              }
            }
          : null,
      icon: SvgPicture.asset(Assets.iconsDelete),
      style: const ButtonStyle(
        padding: WidgetStatePropertyAll(EdgeInsets.all(3)),
      ),
      constraints: const BoxConstraints(minWidth: 0, minHeight: 0),
    );
  }
}
