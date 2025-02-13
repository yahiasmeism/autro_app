// import 'dart:io';

import 'dart:io';

import 'package:autro_app/core/theme/theme_data.dart';
import 'package:autro_app/features/authentication/screens/auth_wrapper.dart';
import 'package:autro_app/features/bills/presentation/bloc/bills_list/bills_list_bloc.dart';
import 'package:autro_app/features/bl-instructions/presentation/bloc/bl_instruction_list/bl_instructions_list_bloc.dart';
import 'package:autro_app/features/customers/presentation/bloc/customers_list/customers_list_bloc.dart';
import 'package:autro_app/features/dashboard/presentation/bloc/dashboard/dashboard_cubit.dart';
import 'package:autro_app/features/deals/presentation/bloc/deal_bills_list/deal_bills_list_bloc.dart';
import 'package:autro_app/features/deals/presentation/bloc/deal_details/deal_details_cubit.dart';
import 'package:autro_app/features/deals/presentation/bloc/deals_list/deals_list_bloc.dart';
import 'package:autro_app/features/home/bloc/home_bloc.dart';
import 'package:autro_app/features/packing-lists/presentation/bloc/packing_lists/packing_lists_bloc.dart';
import 'package:autro_app/features/proformas/presentation/bloc/customers_proformas_list/customers_proformas_list_bloc.dart';
import 'package:autro_app/features/proformas/presentation/bloc/suppliers_proformas_list/suppliers_proformas_list_bloc.dart';
import 'package:autro_app/features/settings/presentation/bloc/bank_accounts_list/bank_accounts_list_cubit.dart';
import 'package:autro_app/features/settings/presentation/bloc/company/company_cubit.dart';
import 'package:autro_app/features/settings/presentation/bloc/users_list/users_list_cubit.dart';
import 'package:autro_app/features/shipping-invoices/presentation/bloc/shipping_invoice_list/shipping_invoices_list_bloc.dart';
import 'package:autro_app/features/suppliers/presentation/bloc/suppliers_list/suppliers_list_bloc.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'core/di/di.dart';
import 'core/storage/hive_box_manager.dart';
import 'features/authentication/bloc/app_auth/app_auth_bloc.dart';
import 'features/invoices/presentation/bloc/customers_invoices_list/customers_invoices_list_bloc.dart';
import 'features/invoices/presentation/bloc/suppliers_invoices_list/suppliers_invoices_list_bloc.dart';
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
          create: (context) => sl<HomeBloc>(),
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
          create: (context) => sl<CustomersProformasListBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<CustomersInvoicesListBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<BillsListBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<ShippingInvoicesListBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<DealsListBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<DealDetailsCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<DealBillsListBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<SuppliersInvoicesListBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<SuppliersProformasListBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<PackingListsBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<DashboardCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<BlInstructionsListBloc>(),
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
