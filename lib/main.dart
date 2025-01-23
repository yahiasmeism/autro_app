// import 'dart:io';

import 'dart:io';

import 'package:autro_app/core/theme/theme_data.dart';
import 'package:autro_app/features/authentication/screens/auth_wrapper.dart';
import 'package:autro_app/features/customers/presentation/bloc/customers_list/customers_list_bloc.dart';
import 'package:autro_app/features/home/bloc/home_bloc.dart';
import 'package:autro_app/features/proformas/presentation/bloc/proformas_list/proformas_list_bloc.dart';
import 'package:autro_app/features/settings/presentation/bloc/bank_accounts_list/bank_accounts_list_cubit.dart';
import 'package:autro_app/features/settings/presentation/bloc/company/company_cubit.dart';
import 'package:autro_app/features/settings/presentation/bloc/users_list/users_list_cubit.dart';
import 'package:autro_app/features/suppliers/presentation/bloc/suppliers_list/suppliers_list_bloc.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'core/di/di.dart';
import 'core/storage/hive_box_manager.dart';
import 'features/authentication/bloc/app_auth/app_auth_bloc.dart';
import 'features/invoices/presentation/bloc/invoices_list/invoices_list_bloc.dart';
import 'features/settings/presentation/bloc/invoice_settings/invoice_settings_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection(Environment.prod);
  await HiveBoxManager.init();

  runApp(const MyApp());
  _initializeDesktopWindow();
  // debugPaintSizeEnabled = true;
}

_initializeDesktopWindow() {
  if (Platform.isWindows) {
    doWhenWindowReady(() {
      const initialWidth = 1300.0;
      const aspectRatio = 16 / 9;
      appWindow
        ..minSize = const Size(initialWidth, initialWidth / aspectRatio)
        ..size = const Size(initialWidth, initialWidth / aspectRatio)
        ..maxSize = const Size(1920, 1080)
        ..alignment = Alignment.center
        ..maximize()
        ..show();
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AppAuthBloc>()..add(CheckAuthenticationAppEvent()),
        ),
        BlocProvider(
          create: (context) => sl<HomeBloc>()..add(BlocCreatedEvent()),
        ),

        // events on AuthWrapper
        BlocProvider(
          create: (context) => sl<CustomersListBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<SuppliersListBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<CompanyCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<BankAccountsListCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<UsersListCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<InvoiceSettingsCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<ProformasListBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<InvoicesListBloc>(),
        ),
      ],
      child: MaterialApp(
        theme: getTheme(),
        debugShowCheckedModeBanner: false,
        home: const AuthWrapper(),
      ),
    );
  }
}
