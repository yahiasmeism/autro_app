import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/widgets/adaptive_layout.dart';
import 'package:autro_app/features/settings/presentation/bloc/bank_accounts_list/bank_accounts_list_cubit.dart';
import 'package:autro_app/features/settings/presentation/bloc/company/company_cubit.dart';
import 'package:autro_app/features/settings/presentation/layouts/screen_settings_desktop_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<CompanyCubit>()..getCompany(),
        ),
        BlocProvider(
          create: (context) => sl<BankAccountsListCubit>(),
        ),
      ],
      child: AdaptiveLayout(
        mobile: (context) => const Center(child: Text('Settings Mobile Layout')),
        desktop: (context) => const ScreenSettingsDesktopLayout(),
      ),
    );
  }
}
