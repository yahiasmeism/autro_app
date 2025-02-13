import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/features/bills/presentation/bloc/bills_list/bills_list_bloc.dart';
import 'package:autro_app/features/bl-instructions/presentation/bloc/bl_instruction_list/bl_instructions_list_bloc.dart';
import 'package:autro_app/features/customers/presentation/bloc/customers_list/customers_list_bloc.dart';
import 'package:autro_app/features/dashboard/presentation/bloc/dashboard/dashboard_cubit.dart';
import 'package:autro_app/features/deals/presentation/bloc/deals_list/deals_list_bloc.dart';
import 'package:autro_app/features/home/bloc/home_bloc.dart';
import 'package:autro_app/features/invoices/presentation/bloc/customers_invoices_list/customers_invoices_list_bloc.dart';
import 'package:autro_app/features/invoices/presentation/bloc/suppliers_invoices_list/suppliers_invoices_list_bloc.dart';
import 'package:autro_app/features/packing-lists/presentation/bloc/packing_lists/packing_lists_bloc.dart';
import 'package:autro_app/features/proformas/presentation/bloc/customers_proformas_list/customers_proformas_list_bloc.dart';
import 'package:autro_app/features/settings/presentation/bloc/bank_accounts_list/bank_accounts_list_cubit.dart';
import 'package:autro_app/features/settings/presentation/bloc/company/company_cubit.dart';
import 'package:autro_app/features/settings/presentation/bloc/users_list/users_list_cubit.dart';
import 'package:autro_app/features/shipping-invoices/presentation/bloc/shipping_invoice_list/shipping_invoices_list_bloc.dart';
import 'package:autro_app/features/suppliers/presentation/bloc/suppliers_list/suppliers_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../home/screens/home_wrapper.dart';
import '../../proformas/presentation/bloc/suppliers_proformas_list/suppliers_proformas_list_bloc.dart';
import '../../settings/presentation/bloc/invoice_settings/invoice_settings_cubit.dart';
import '../bloc/app_auth/app_auth_bloc.dart';
import 'login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppAuthBloc, AppAuthState>(
      listener: listener,
      buildWhen: (previous, current) {
        return current is AuthenticatedState || current is UnAuthenticatedState || current is LoggedOutState;
      },
      builder: (context, state) {
        if (state is InitialAppAuthState) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text('Checking authentication...', style: TextStyles.font18Regular),
                ],
              ),
            ),
          );
        }
        if (state is AuthenticatedState) {
          return const HomeWrapper();
        } else if (state is UnAuthenticatedState) {
          return const LoginScreen();
        } else if (state is LoggedOutState) {
          return const LoginScreen();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  void listener(BuildContext context, AppAuthState state) {
    if (state is AuthenticatedState) {
      sl<HomeBloc>().add(BlocCreatedEvent());
      context.read<CustomersListBloc>().add(GetCustomersListEvent());
      context.read<SuppliersListBloc>().add(GetSuppliersListEvent());
      context.read<CompanyCubit>().getCompany();
      context.read<BankAccountsListCubit>().getBankAccountList();
      context.read<UsersListCubit>().getUsersList();
      context.read<InvoiceSettingsCubit>().getInvoiceSettings();
      context.read<CustomersProformasListBloc>().add(GetProformasListEvent());
      context.read<CustomersInvoicesListBloc>().add(GetCustomersInvoicesListEvent());
      context.read<BillsListBloc>().add(GetBillsListEvent());
      context.read<ShippingInvoicesListBloc>().add(GetShippingInvoicesListEvent());
      context.read<DealsListBloc>().add(GetDealsListEvent());
      context.read<SuppliersInvoicesListBloc>().add(GetSuppliersInvoicesListEvent());
      context.read<SuppliersProformasListBloc>().add(GetSuppliersProformasListEvent());
      context.read<PackingListsBloc>().add(GetPackingListsEvent());
      context.read<DashboardCubit>().getDashboard();
      context.read<BlInstructionsListBloc>().add(GetBlInstructionsListEvent());
    }
  }
}
