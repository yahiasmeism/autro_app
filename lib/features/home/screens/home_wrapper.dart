import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/adaptive_layout.dart';
import 'package:autro_app/features/home/layouts/home_desktop_layout.dart';
import 'package:autro_app/features/home/layouts/home_mobile_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/loading_dialog.dart';
import '../../authentication/bloc/app_auth/app_auth_bloc.dart';

class HomeWrapper extends StatelessWidget {
  const HomeWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppAuthBloc, AppAuthState>(
      listener: listener,
      child: AdaptiveLayout(
        mobile: (context) => const HomeMobileLayout(),
        desktop: (context) => const HomeWrapperDesktopLayout(),
      ),
    );
  }

  void listener(BuildContext context, AppAuthState state) {
    if (state is LoggingOutState) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const Center(
          child: LoadingDialog(message: 'Logging Out'),
        ),
      );
    }
    if (state is LoggedOutState) {
      NavUtil.pop(context);
    }
  }
}
