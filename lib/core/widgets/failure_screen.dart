import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/errors/server_failure.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';

import '../errors/failure_mapper.dart';

class FailureScreen extends StatelessWidget {
  // if that should be the default behaviour delete it and make the dependency on the onRetryTap directly
  final bool hideButtonOnNullCallback;
  final Failure failure;
  final String? secondaryBtnLabel;
  final Function()? onSecondaryTap;
  final Function()? onRetryTap;
  const FailureScreen({
    super.key,
    required this.failure,
    this.secondaryBtnLabel,
    this.onSecondaryTap,
    this.onRetryTap,
    this.hideButtonOnNullCallback = true,
  });

  bool get isSessionExpired => failure is UnauthorizedFailure;

  handleLogout(BuildContext context) {
    // NavUtil.popToRoot(context);
    // context.read<AuthCubit>().onLogout(false);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        width: screenWidth,
        height: screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            buildIconWidget(screenWidth),
            buildErrorMessage(context),
            const SizedBox(height: 50),
            buildPrimaryButton(),
          ],
        ),
      ),
    );
  }

  Widget buildIconWidget(double screenWidth) {
    return Icon(getErrorIconFromFailure(failure), size: 35, color: AppColors.iconColor);
  }

  Widget buildErrorMessage(BuildContext context) {
    return SingleChildScrollView(
      child: Text(
        getErrorMsgFromFailure(failure),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.secondaryOpacity50),
      ),
    );
  }

  Widget buildPrimaryButton() {
    if (onRetryTap == null && hideButtonOnNullCallback) {
      return const SizedBox();
    }
    return IntrinsicWidth(
      child: PrimaryButton(
        bgColor: AppColors.secondary,
        labelText: 'Retry',
        onPressed: onRetryTap,
      ),
    );
  }
}
