// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:autro_app/core/api/api_client.dart' as _i228;
import 'package:autro_app/core/di/injectable_modules.dart' as _i564;
import 'package:autro_app/core/network_info/network_info.dart' as _i646;
import 'package:autro_app/core/storage/app_preferences.dart' as _i123;
import 'package:autro_app/features/authentication/bloc/app_auth/app_auth_bloc.dart'
    as _i51;
import 'package:autro_app/features/authentication/bloc/login/login_cubit.dart'
    as _i30;
import 'package:autro_app/features/authentication/bloc/register/register_cubit.dart'
    as _i173;
import 'package:autro_app/features/authentication/data/data_sources/auth_remote_data_source.dart'
    as _i388;
import 'package:autro_app/features/authentication/data/repo/auth_repo.dart'
    as _i288;
import 'package:autro_app/features/bills/data/data_sources/remote/bills_remote_data_source.dart'
    as _i77;
import 'package:autro_app/features/bills/data/repositories_impl/bills_repository_impl.dart'
    as _i801;
import 'package:autro_app/features/bills/domin/repostiries/bills_respository.dart'
    as _i292;
import 'package:autro_app/features/bills/domin/use_cases/add_bill_use_case.dart'
    as _i671;
import 'package:autro_app/features/bills/domin/use_cases/delete_bill_use_case.dart'
    as _i321;
import 'package:autro_app/features/bills/domin/use_cases/get_bill_use_case.dart'
    as _i588;
import 'package:autro_app/features/bills/domin/use_cases/get_bills_list_use_case.dart'
    as _i218;
import 'package:autro_app/features/bills/domin/use_cases/get_bills_summary_use_case.dart'
    as _i372;
import 'package:autro_app/features/bills/domin/use_cases/update_bill_use_case.dart'
    as _i745;
import 'package:autro_app/features/bills/presentation/bloc/bill_form/bill_form_bloc.dart'
    as _i363;
import 'package:autro_app/features/bills/presentation/bloc/bills_list/bills_list_bloc.dart'
    as _i813;
import 'package:autro_app/features/customers/data/datasources/customers_remote_datesourse.dart'
    as _i438;
import 'package:autro_app/features/customers/data/repositories/customers_repository_impl.dart'
    as _i388;
import 'package:autro_app/features/customers/domin/repositories/customers_repository.dart'
    as _i54;
import 'package:autro_app/features/customers/domin/usecases/create_customer_usecase.dart'
    as _i116;
import 'package:autro_app/features/customers/domin/usecases/delete_customer_usecase.dart'
    as _i207;
import 'package:autro_app/features/customers/domin/usecases/get_customer_usecase.dart'
    as _i832;
import 'package:autro_app/features/customers/domin/usecases/get_customers_list_usecase.dart'
    as _i486;
import 'package:autro_app/features/customers/domin/usecases/update_customer_usecase.dart'
    as _i134;
import 'package:autro_app/features/customers/presentation/bloc/customer_details/customer_details_cubit.dart'
    as _i825;
import 'package:autro_app/features/customers/presentation/bloc/customer_form/customer_form_bloc.dart'
    as _i512;
import 'package:autro_app/features/customers/presentation/bloc/customers_list/customers_list_bloc.dart'
    as _i815;
import 'package:autro_app/features/deals/data/data_sources/remote/deals_bills_remote_data_source.dart'
    as _i816;
import 'package:autro_app/features/deals/data/data_sources/remote/deals_remote_data_source.dart'
    as _i1017;
import 'package:autro_app/features/deals/data/repositories_impl/deals_bills_repository_impl.dart'
    as _i1070;
import 'package:autro_app/features/deals/data/repositories_impl/deals_repository_impl.dart'
    as _i976;
import 'package:autro_app/features/deals/domin/repositories/deals_bills_repository.dart'
    as _i874;
import 'package:autro_app/features/deals/domin/repositories/deals_repository.dart'
    as _i343;
import 'package:autro_app/features/deals/domin/use_cases/create_deal_bill_use_case.dart'
    as _i411;
import 'package:autro_app/features/deals/domin/use_cases/create_deal_use_case.dart'
    as _i776;
import 'package:autro_app/features/deals/domin/use_cases/delete_deal_bill_use_case.dart'
    as _i878;
import 'package:autro_app/features/deals/domin/use_cases/delete_deal_use_case.dart'
    as _i223;
import 'package:autro_app/features/deals/domin/use_cases/get_deal_use_case.dart'
    as _i745;
import 'package:autro_app/features/deals/domin/use_cases/get_deals_bills_list_use_case.dart'
    as _i728;
import 'package:autro_app/features/deals/domin/use_cases/get_deals_list_use_case.dart'
    as _i419;
import 'package:autro_app/features/deals/domin/use_cases/update_deal_bill_use_case.dart'
    as _i826;
import 'package:autro_app/features/deals/domin/use_cases/update_deal_use_case.dart'
    as _i473;
import 'package:autro_app/features/deals/presentation/bloc/deal_bill_form/deal_bill_form_bloc.dart'
    as _i144;
import 'package:autro_app/features/deals/presentation/bloc/deal_bills_list/deal_bills_list_bloc.dart'
    as _i366;
import 'package:autro_app/features/deals/presentation/bloc/deal_details/deal_details_cubit.dart'
    as _i395;
import 'package:autro_app/features/deals/presentation/bloc/deals_list/deals_list_bloc.dart'
    as _i594;
import 'package:autro_app/features/home/bloc/home_bloc.dart' as _i80;
import 'package:autro_app/features/invoices/data/data_sources/remote/customers_invoices_remote_data_source.dart'
    as _i818;
import 'package:autro_app/features/invoices/data/data_sources/remote/suppliers_invoices_remote_data_source.dart'
    as _i514;
import 'package:autro_app/features/invoices/data/repositories_impl/customers_invoices_repository_impl.dart'
    as _i1011;
import 'package:autro_app/features/invoices/data/repositories_impl/suppliers_invoices_repository_impl.dart'
    as _i54;
import 'package:autro_app/features/invoices/domin/repositories/customer_invoices_repository.dart'
    as _i936;
import 'package:autro_app/features/invoices/domin/repositories/supplier_invoices_repository.dart'
    as _i557;
import 'package:autro_app/features/invoices/domin/use_cases/create_customer_invoice_use_case.dart'
    as _i954;
import 'package:autro_app/features/invoices/domin/use_cases/create_supplier_invoice_use_case.dart'
    as _i518;
import 'package:autro_app/features/invoices/domin/use_cases/delete_customer_invoice_use_case.dart'
    as _i704;
import 'package:autro_app/features/invoices/domin/use_cases/delete_supplier_invoice_use_case.dart'
    as _i952;
import 'package:autro_app/features/invoices/domin/use_cases/get_customers_invoices_list_use_case.dart'
    as _i920;
import 'package:autro_app/features/invoices/domin/use_cases/get_supplier_invoices_list_use_case.dart'
    as _i18;
import 'package:autro_app/features/invoices/domin/use_cases/update_customer_invoice_use_case.dart'
    as _i981;
import 'package:autro_app/features/invoices/domin/use_cases/update_supplier_invoice_use_case.dart'
    as _i763;
import 'package:autro_app/features/invoices/presentation/bloc/customer_invoice_form/customer_invoice_form_cubit.dart'
    as _i510;
import 'package:autro_app/features/invoices/presentation/bloc/customers_invoices_list/customers_invoices_list_bloc.dart'
    as _i962;
import 'package:autro_app/features/invoices/presentation/bloc/invoice_pdf/invoice_pdf_cubit.dart'
    as _i43;
import 'package:autro_app/features/invoices/presentation/bloc/supplier_invoice_form/supplier_invoice_form_bloc.dart'
    as _i254;
import 'package:autro_app/features/invoices/presentation/bloc/suppliers_invoices_list/suppliers_invoices_list_bloc.dart'
    as _i519;
import 'package:autro_app/features/proformas/data/data_sources/remote/customers_proformas_remote_data_source.dart'
    as _i336;
import 'package:autro_app/features/proformas/data/data_sources/remote/suppliers_invoices_remote_data_source.dart'
    as _i638;
import 'package:autro_app/features/proformas/data/repositories_impl/customers_proformas_repository_impl.dart'
    as _i981;
import 'package:autro_app/features/proformas/data/repositories_impl/suppliers_proformas_repository_impl.dart'
    as _i810;
import 'package:autro_app/features/proformas/domin/repositories/customers_proformas_repository.dart'
    as _i5;
import 'package:autro_app/features/proformas/domin/repositories/supplier_invoices_repository.dart'
    as _i851;
import 'package:autro_app/features/proformas/domin/use_cases/create_customer_proforma_use_case.dart'
    as _i70;
import 'package:autro_app/features/proformas/domin/use_cases/create_supplier_proforma_use_case.dart'
    as _i598;
import 'package:autro_app/features/proformas/domin/use_cases/delete_customer_proforma_use_case.dart'
    as _i360;
import 'package:autro_app/features/proformas/domin/use_cases/delete_supplier_proforma_use_case.dart'
    as _i226;
import 'package:autro_app/features/proformas/domin/use_cases/get_customers_proformas_list_use_case.dart'
    as _i330;
import 'package:autro_app/features/proformas/domin/use_cases/get_supplier_proforma_list_use_case.dart'
    as _i556;
import 'package:autro_app/features/proformas/domin/use_cases/update_customer_proforma_use_case.dart'
    as _i42;
import 'package:autro_app/features/proformas/domin/use_cases/update_supplier_proforma_use_case.dart'
    as _i413;
import 'package:autro_app/features/proformas/presentation/bloc/customer_proforma_form_cubit/customer_proforma_form_cubit.dart'
    as _i1045;
import 'package:autro_app/features/proformas/presentation/bloc/customers_proformas_list/customers_proformas_list_bloc.dart'
    as _i612;
import 'package:autro_app/features/proformas/presentation/bloc/supplier_proforma_form/supplier_proforma_form_bloc.dart'
    as _i792;
import 'package:autro_app/features/proformas/presentation/bloc/suppliers_proformas_list/suppliers_proformas_list_bloc.dart'
    as _i90;
import 'package:autro_app/features/settings/data/datasources/settings_remote_data_source.dart'
    as _i509;
import 'package:autro_app/features/settings/data/repositories_impl/settings_repository_impl.dart'
    as _i923;
import 'package:autro_app/features/settings/domin/repositories/settings_repository.dart'
    as _i275;
import 'package:autro_app/features/settings/domin/use_cases/add_bank_account_use_case.dart'
    as _i232;
import 'package:autro_app/features/settings/domin/use_cases/add_new_user_use_case.dart'
    as _i766;
import 'package:autro_app/features/settings/domin/use_cases/change_company_info_use_case.dart'
    as _i855;
import 'package:autro_app/features/settings/domin/use_cases/delete_bank_account_use_case.dart'
    as _i253;
import 'package:autro_app/features/settings/domin/use_cases/get_bank_account_list_use_case.dart'
    as _i362;
import 'package:autro_app/features/settings/domin/use_cases/get_company_use_case.dart'
    as _i223;
import 'package:autro_app/features/settings/domin/use_cases/get_current_user_use_case.dart'
    as _i533;
import 'package:autro_app/features/settings/domin/use_cases/get_invoice_settings_use_case.dart'
    as _i321;
import 'package:autro_app/features/settings/domin/use_cases/get_users_list_use_case.dart'
    as _i176;
import 'package:autro_app/features/settings/domin/use_cases/remove_user_use_case.dart'
    as _i130;
import 'package:autro_app/features/settings/domin/use_cases/set_invoice_settings_use_case.dart'
    as _i252;
import 'package:autro_app/features/settings/presentation/bloc/bank_accounts_list/bank_accounts_list_cubit.dart'
    as _i827;
import 'package:autro_app/features/settings/presentation/bloc/company/company_cubit.dart'
    as _i326;
import 'package:autro_app/features/settings/presentation/bloc/invoice_settings/invoice_settings_cubit.dart'
    as _i239;
import 'package:autro_app/features/settings/presentation/bloc/users_list/users_list_cubit.dart'
    as _i729;
import 'package:autro_app/features/shipping-invoices/data/data_sources/remote/shipping_invoices_remote_date_source.dart'
    as _i515;
import 'package:autro_app/features/shipping-invoices/data/repository_impl/shipping_invoices_repository_impl.dart'
    as _i364;
import 'package:autro_app/features/shipping-invoices/domin/repositories/shipping_invoices_repository.dart'
    as _i43;
import 'package:autro_app/features/shipping-invoices/domin/usecases/create_shipping_invoice_use_case.dart'
    as _i163;
import 'package:autro_app/features/shipping-invoices/domin/usecases/delete_shipping_invoice_use_case.dart'
    as _i725;
import 'package:autro_app/features/shipping-invoices/domin/usecases/get_shipping_invoices_list_use_case.dart'
    as _i856;
import 'package:autro_app/features/shipping-invoices/domin/usecases/update_shipping_invoices_use_case.dart'
    as _i766;
import 'package:autro_app/features/shipping-invoices/presentation/bloc/shipping_invoice_form/shipping_invoice_form_bloc.dart'
    as _i839;
import 'package:autro_app/features/shipping-invoices/presentation/bloc/shipping_invoice_list/shipping_invoices_list_bloc.dart'
    as _i1020;
import 'package:autro_app/features/suppliers/data/datasources/suppliers_remote_datesourse.dart'
    as _i829;
import 'package:autro_app/features/suppliers/data/repositories/suppliers_repository_impl.dart'
    as _i903;
import 'package:autro_app/features/suppliers/domin/repositoreis/suppliers_repository.dart'
    as _i712;
import 'package:autro_app/features/suppliers/domin/usecases/create_supplier_usecase.dart'
    as _i57;
import 'package:autro_app/features/suppliers/domin/usecases/delete_supplier_usecase.dart'
    as _i226;
import 'package:autro_app/features/suppliers/domin/usecases/get_supplier_usecase.dart'
    as _i941;
import 'package:autro_app/features/suppliers/domin/usecases/get_suppliers_list_usecase.dart'
    as _i884;
import 'package:autro_app/features/suppliers/domin/usecases/update_supplier_usecase.dart'
    as _i428;
import 'package:autro_app/features/suppliers/presentation/bloc/supplier_details/supplier_details_cubit.dart'
    as _i997;
import 'package:autro_app/features/suppliers/presentation/bloc/supplier_form/supplier_form_bloc.dart'
    as _i323;
import 'package:autro_app/features/suppliers/presentation/bloc/suppliers_list/suppliers_list_bloc.dart'
    as _i497;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final iTMCoreInjectableModules = _$ITMCoreInjectableModules();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => iTMCoreInjectableModules.sharedPreferences,
      preResolve: true,
    );
    gh.factory<_i825.CustomerDetailsCubit>(() => _i825.CustomerDetailsCubit());
    gh.factory<_i997.SupplierDetailsCubit>(() => _i997.SupplierDetailsCubit());
    gh.lazySingleton<_i80.HomeBloc>(() => _i80.HomeBloc());
    gh.lazySingleton<_i646.NetworkInfo>(() => _i646.NetworkInfoImpl());
    gh.lazySingleton<_i123.AppPreferences>(() => _i123.AppPreferencesImpl(
        sharedPreferences: gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i228.ApiClient>(
        () => _i228.DioClient(gh<_i123.AppPreferences>()));
    gh.lazySingleton<_i336.CustomersProformasRemoteDataSource>(() =>
        _i336.CustomersProformasRemoteDataSourceImpl(
            client: gh<_i228.ApiClient>()));
    gh.lazySingleton<_i509.SettingsRemoteDataSource>(() =>
        _i509.SettingsRemoteDataSourceImpl(client: gh<_i228.ApiClient>()));
    gh.lazySingleton<_i77.BillsRemoteDataSource>(
        () => _i77.BillsRemoteDataSourceImpl(apiClient: gh<_i228.ApiClient>()));
    gh.lazySingleton<_i514.SuppliersInvoicesRemoteDataSource>(() =>
        _i514.SuppliersInvoicesRemoteDataSourceImpl(
            client: gh<_i228.ApiClient>()));
    gh.lazySingleton<_i818.CustomersInvoicesRemoteDataSource>(() =>
        _i818.CustomersInvoicesRemoteDataSourceImpl(
            client: gh<_i228.ApiClient>()));
    gh.lazySingleton<_i5.CustomersProformasRepository>(
        () => _i981.CustomersProformasRepositoryImpl(
              remoteDataSource: gh<_i336.CustomersProformasRemoteDataSource>(),
              networkInfo: gh<_i646.NetworkInfo>(),
            ));
    gh.lazySingleton<_i515.ShippingInvoicesRemoteDateSource>(() =>
        _i515.ShippingInvoicesRemoteDateSourceImpl(
            client: gh<_i228.ApiClient>()));
    gh.lazySingleton<_i816.DealsBillsRemoteDataSource>(() =>
        _i816.DealsBillsRemoteDataSourceImpl(apiClient: gh<_i228.ApiClient>()));
    gh.lazySingleton<_i438.CustomersRemoteDataSource>(() =>
        _i438.CustomersRemoteDataSourceImpl(apiClient: gh<_i228.ApiClient>()));
    gh.lazySingleton<_i638.SuppliersProformasRemoteDataSource>(() =>
        _i638.SuppliersProformasRemoteDataSourceImpl(
            client: gh<_i228.ApiClient>()));
    gh.lazySingleton<_i388.AuthRemoteDataSource>(
        () => _i388.AuthRemoteDataSourceImpl(apiClient: gh<_i228.ApiClient>()));
    gh.lazySingleton<_i275.SettingsRepository>(
        () => _i923.SettingsRepositoryImpl(
              networkInfo: gh<_i646.NetworkInfo>(),
              remoteDataSource: gh<_i509.SettingsRemoteDataSource>(),
            ));
    gh.lazySingleton<_i936.CustomerInvoicesRepository>(
        () => _i1011.CustomersInvoicesRepositoryImpl(
              remoteDataSource: gh<_i818.CustomersInvoicesRemoteDataSource>(),
              networkInfo: gh<_i646.NetworkInfo>(),
            ));
    gh.lazySingleton<_i232.AddBankAccountUseCase>(() =>
        _i232.AddBankAccountUseCase(
            settingsRepository: gh<_i275.SettingsRepository>()));
    gh.lazySingleton<_i253.DeleteBankAccountUseCase>(() =>
        _i253.DeleteBankAccountUseCase(
            settingsRepository: gh<_i275.SettingsRepository>()));
    gh.lazySingleton<_i321.GetInvoiceSettingsUseCase>(() =>
        _i321.GetInvoiceSettingsUseCase(
            settingsRepository: gh<_i275.SettingsRepository>()));
    gh.lazySingleton<_i130.RemoveUserUseCase>(() => _i130.RemoveUserUseCase(
        settingsRepository: gh<_i275.SettingsRepository>()));
    gh.lazySingleton<_i252.SetInvoiceSettingsUseCase>(() =>
        _i252.SetInvoiceSettingsUseCase(
            settingsRepository: gh<_i275.SettingsRepository>()));
    gh.lazySingleton<_i829.SuppliersRemoteDataSource>(() =>
        _i829.SuppliersRemoteDataSourceImpl(apiClient: gh<_i228.ApiClient>()));
    gh.lazySingleton<_i1017.DealsRemoteDataSource>(
        () => _i1017.DealsRemoteDataSourceImpl(client: gh<_i228.ApiClient>()));
    gh.lazySingleton<_i43.ShippingInvoicesRepository>(
        () => _i364.ShippingInvoicesRepositoryImpl(
              networkInfo: gh<_i646.NetworkInfo>(),
              remoteDataSource: gh<_i515.ShippingInvoicesRemoteDateSource>(),
            ));
    gh.lazySingleton<_i288.AuthRepo>(() => _i288.AuthRepoImpl(
          remoteDataSource: gh<_i388.AuthRemoteDataSource>(),
          appPreferences: gh<_i123.AppPreferences>(),
          networkInfo: gh<_i646.NetworkInfo>(),
        ));
    gh.lazySingleton<_i54.CustomersRepository>(
        () => _i388.CustomersRepositoryImpl(
              remoteDataSource: gh<_i438.CustomersRemoteDataSource>(),
              networkInfo: gh<_i646.NetworkInfo>(),
            ));
    gh.lazySingleton<_i954.CreateCustomerInvoiceUseCase>(() =>
        _i954.CreateCustomerInvoiceUseCase(
            repository: gh<_i936.CustomerInvoicesRepository>()));
    gh.lazySingleton<_i920.GetCustomersInvoicesListUseCase>(() =>
        _i920.GetCustomersInvoicesListUseCase(
            repository: gh<_i936.CustomerInvoicesRepository>()));
    gh.lazySingleton<_i712.SuppliersRepository>(
        () => _i903.SuppliersRepositoryImpl(
              remoteDataSource: gh<_i829.SuppliersRemoteDataSource>(),
              networkInfo: gh<_i646.NetworkInfo>(),
            ));
    gh.lazySingleton<_i884.GetSuppliersListUsecase>(() =>
        _i884.GetSuppliersListUsecase(
            supplierRepository: gh<_i712.SuppliersRepository>()));
    gh.lazySingleton<_i851.SupplierProformasRepository>(
        () => _i810.SuppliersProformasRepositoryImpl(
              remoteDataSource: gh<_i638.SuppliersProformasRemoteDataSource>(),
              networkInfo: gh<_i646.NetworkInfo>(),
            ));
    gh.lazySingleton<_i766.UpdateShippingInvoicesUseCase>(() =>
        _i766.UpdateShippingInvoicesUseCase(
            shippingInvoiceRepository: gh<_i43.ShippingInvoicesRepository>()));
    gh.lazySingleton<_i70.CreateCustomerProformaUseCase>(() =>
        _i70.CreateCustomerProformaUseCase(
            repository: gh<_i5.CustomersProformasRepository>()));
    gh.lazySingleton<_i330.GetCustomersProformasListUseCase>(() =>
        _i330.GetCustomersProformasListUseCase(
            repository: gh<_i5.CustomersProformasRepository>()));
    gh.lazySingleton<_i343.DealsRepository>(() => _i976.DealsRepositoryImpl(
          remoteDataSource: gh<_i1017.DealsRemoteDataSource>(),
          networkInfo: gh<_i646.NetworkInfo>(),
        ));
    gh.lazySingleton<_i766.AddNewUserUseCase>(() =>
        _i766.AddNewUserUseCase(repository: gh<_i275.SettingsRepository>()));
    gh.lazySingleton<_i855.ChangeCompanyInfoUseCase>(() =>
        _i855.ChangeCompanyInfoUseCase(
            repository: gh<_i275.SettingsRepository>()));
    gh.lazySingleton<_i362.GetBankAccountListUseCase>(() =>
        _i362.GetBankAccountListUseCase(
            repository: gh<_i275.SettingsRepository>()));
    gh.lazySingleton<_i223.GetCompanyUseCase>(() =>
        _i223.GetCompanyUseCase(repository: gh<_i275.SettingsRepository>()));
    gh.lazySingleton<_i176.GetUsersListUseCase>(() =>
        _i176.GetUsersListUseCase(repository: gh<_i275.SettingsRepository>()));
    gh.lazySingleton<_i557.SupplierInvoicesRepository>(
        () => _i54.SuppliersInvoicesRepositoryImpl(
              remoteDataSource: gh<_i514.SuppliersInvoicesRemoteDataSource>(),
              networkInfo: gh<_i646.NetworkInfo>(),
            ));
    gh.lazySingleton<_i874.DealsBillsRepository>(
        () => _i1070.DealBillRepositoryImpl(
              remoteDataSource: gh<_i816.DealsBillsRemoteDataSource>(),
              networkInfo: gh<_i646.NetworkInfo>(),
            ));
    gh.lazySingleton<_i292.BillsRepository>(() => _i801.BillsRepositoryImpl(
          billsRemoteDataSource: gh<_i77.BillsRemoteDataSource>(),
          networkInfo: gh<_i646.NetworkInfo>(),
        ));
    gh.lazySingleton<_i704.DeleteCustomerInvoiceUseCase>(() =>
        _i704.DeleteCustomerInvoiceUseCase(
            invoicesRepository: gh<_i936.CustomerInvoicesRepository>()));
    gh.lazySingleton<_i981.UpdateCustomerInvoiceUseCase>(() =>
        _i981.UpdateCustomerInvoiceUseCase(
            invoicesRepository: gh<_i936.CustomerInvoicesRepository>()));
    gh.lazySingleton<_i360.DeleteCustomerProformaUseCase>(() =>
        _i360.DeleteCustomerProformaUseCase(
            proformasRepository: gh<_i5.CustomersProformasRepository>()));
    gh.lazySingleton<_i42.UpdateCustomerProformaUseCase>(() =>
        _i42.UpdateCustomerProformaUseCase(
            proformasRepository: gh<_i5.CustomersProformasRepository>()));
    gh.lazySingleton<_i952.DeleteSupplierInvoiceUseCase>(() =>
        _i952.DeleteSupplierInvoiceUseCase(
            invoicesRepository: gh<_i557.SupplierInvoicesRepository>()));
    gh.lazySingleton<_i763.UpdateSupplierInvoiceUseCase>(() =>
        _i763.UpdateSupplierInvoiceUseCase(
            invoicesRepository: gh<_i557.SupplierInvoicesRepository>()));
    gh.factory<_i510.CustomerInvoiceFormCubit>(
        () => _i510.CustomerInvoiceFormCubit(
              gh<_i954.CreateCustomerInvoiceUseCase>(),
              gh<_i981.UpdateCustomerInvoiceUseCase>(),
            ));
    gh.lazySingleton<_i57.CreateSupplierUsecase>(() =>
        _i57.CreateSupplierUsecase(
            suplliersRepository: gh<_i712.SuppliersRepository>()));
    gh.factory<_i1045.CustomerProformaFormCubit>(
        () => _i1045.CustomerProformaFormCubit(
              gh<_i70.CreateCustomerProformaUseCase>(),
              gh<_i42.UpdateCustomerProformaUseCase>(),
            ));
    gh.lazySingleton<_i163.CreateShippingInvoiceUseCase>(() =>
        _i163.CreateShippingInvoiceUseCase(
            repository: gh<_i43.ShippingInvoicesRepository>()));
    gh.lazySingleton<_i725.DeleteShippingInvoiceUseCase>(() =>
        _i725.DeleteShippingInvoiceUseCase(
            repository: gh<_i43.ShippingInvoicesRepository>()));
    gh.lazySingleton<_i856.GetShippingInvoicesListUseCase>(() =>
        _i856.GetShippingInvoicesListUseCase(
            repository: gh<_i43.ShippingInvoicesRepository>()));
    gh.lazySingleton<_i518.CreateSupplierInvoiceUseCase>(() =>
        _i518.CreateSupplierInvoiceUseCase(
            repository: gh<_i557.SupplierInvoicesRepository>()));
    gh.lazySingleton<_i18.GetSuppliersInvoicesListUseCase>(() =>
        _i18.GetSuppliersInvoicesListUseCase(
            repository: gh<_i557.SupplierInvoicesRepository>()));
    gh.factory<_i1020.ShippingInvoicesListBloc>(
        () => _i1020.ShippingInvoicesListBloc(
              gh<_i856.GetShippingInvoicesListUseCase>(),
              gh<_i725.DeleteShippingInvoiceUseCase>(),
              gh<_i43.ShippingInvoicesRepository>(),
              gh<_i766.UpdateShippingInvoicesUseCase>(),
              gh<_i163.CreateShippingInvoiceUseCase>(),
            ));
    gh.lazySingleton<_i239.InvoiceSettingsCubit>(
        () => _i239.InvoiceSettingsCubit(
              gh<_i321.GetInvoiceSettingsUseCase>(),
              gh<_i252.SetInvoiceSettingsUseCase>(),
            ));
    gh.lazySingleton<_i326.CompanyCubit>(() => _i326.CompanyCubit(
          gh<_i223.GetCompanyUseCase>(),
          gh<_i855.ChangeCompanyInfoUseCase>(),
        ));
    gh.lazySingleton<_i598.CreateSupplierProformaUseCase>(() =>
        _i598.CreateSupplierProformaUseCase(
            repository: gh<_i851.SupplierProformasRepository>()));
    gh.lazySingleton<_i556.GetSuppliersProformasListUseCase>(() =>
        _i556.GetSuppliersProformasListUseCase(
            repository: gh<_i851.SupplierProformasRepository>()));
    gh.lazySingleton<_i533.GetCurrentUserUseCase>(
        () => _i533.GetCurrentUserUseCase(authRepo: gh<_i288.AuthRepo>()));
    gh.factory<_i827.BankAccountsListCubit>(() => _i827.BankAccountsListCubit(
          gh<_i362.GetBankAccountListUseCase>(),
          gh<_i232.AddBankAccountUseCase>(),
          gh<_i253.DeleteBankAccountUseCase>(),
        ));
    gh.factory<_i43.InvoicePdfCubit>(
        () => _i43.InvoicePdfCubit(gh<_i223.GetCompanyUseCase>()));
    gh.factory<_i519.SuppliersInvoicesListBloc>(
        () => _i519.SuppliersInvoicesListBloc(
              gh<_i18.GetSuppliersInvoicesListUseCase>(),
              gh<_i557.SupplierInvoicesRepository>(),
              gh<_i952.DeleteSupplierInvoiceUseCase>(),
              gh<_i763.UpdateSupplierInvoiceUseCase>(),
              gh<_i518.CreateSupplierInvoiceUseCase>(),
            ));
    gh.lazySingleton<_i116.CreateCustomerUsecase>(() =>
        _i116.CreateCustomerUsecase(
            customersRepository: gh<_i54.CustomersRepository>()));
    gh.lazySingleton<_i207.DeleteCustomerUsecase>(() =>
        _i207.DeleteCustomerUsecase(
            customersRepository: gh<_i54.CustomersRepository>()));
    gh.lazySingleton<_i486.GetCustomersListUsecase>(() =>
        _i486.GetCustomersListUsecase(
            customersRepository: gh<_i54.CustomersRepository>()));
    gh.lazySingleton<_i832.GetCustomerUsecase>(() => _i832.GetCustomerUsecase(
        customersRepository: gh<_i54.CustomersRepository>()));
    gh.lazySingleton<_i134.UpdateCustomerUsecase>(() =>
        _i134.UpdateCustomerUsecase(
            customersRepository: gh<_i54.CustomersRepository>()));
    gh.lazySingleton<_i226.DeleteSupplierUsecase>(() =>
        _i226.DeleteSupplierUsecase(
            suppliersRepository: gh<_i712.SuppliersRepository>()));
    gh.lazySingleton<_i941.GetSupplierUsecase>(() => _i941.GetSupplierUsecase(
        suppliersRepository: gh<_i712.SuppliersRepository>()));
    gh.lazySingleton<_i428.UpdateSupplierUsecase>(() =>
        _i428.UpdateSupplierUsecase(
            suppliersRepository: gh<_i712.SuppliersRepository>()));
    gh.factory<_i173.RegisterCubit>(
        () => _i173.RegisterCubit(gh<_i288.AuthRepo>()));
    gh.lazySingleton<_i51.AppAuthBloc>(
        () => _i51.AppAuthBloc(gh<_i288.AuthRepo>()));
    gh.lazySingleton<_i776.CreateDealUseCase>(
        () => _i776.CreateDealUseCase(repository: gh<_i343.DealsRepository>()));
    gh.lazySingleton<_i419.GetDealsListUseCase>(() =>
        _i419.GetDealsListUseCase(repository: gh<_i343.DealsRepository>()));
    gh.lazySingleton<_i473.UpdateDealUseCase>(
        () => _i473.UpdateDealUseCase(repository: gh<_i343.DealsRepository>()));
    gh.factory<_i962.CustomersInvoicesListBloc>(
        () => _i962.CustomersInvoicesListBloc(
              gh<_i920.GetCustomersInvoicesListUseCase>(),
              gh<_i936.CustomerInvoicesRepository>(),
              gh<_i704.DeleteCustomerInvoiceUseCase>(),
              gh<_i981.UpdateCustomerInvoiceUseCase>(),
              gh<_i954.CreateCustomerInvoiceUseCase>(),
            ));
    gh.factory<_i815.CustomersListBloc>(() => _i815.CustomersListBloc(
          gh<_i486.GetCustomersListUsecase>(),
          gh<_i54.CustomersRepository>(),
          gh<_i207.DeleteCustomerUsecase>(),
          gh<_i134.UpdateCustomerUsecase>(),
          gh<_i116.CreateCustomerUsecase>(),
        ));
    gh.lazySingleton<_i223.DeleteDealUseCase>(() =>
        _i223.DeleteDealUseCase(dealsRepository: gh<_i343.DealsRepository>()));
    gh.lazySingleton<_i745.GetDealUseCase>(() =>
        _i745.GetDealUseCase(dealsRepository: gh<_i343.DealsRepository>()));
    gh.lazySingleton<_i226.DeleteSupplierProformaUseCase>(() =>
        _i226.DeleteSupplierProformaUseCase(
            proformasRepository: gh<_i851.SupplierProformasRepository>()));
    gh.lazySingleton<_i413.UpdateSupplierProformaUseCase>(() =>
        _i413.UpdateSupplierProformaUseCase(
            proformasRepository: gh<_i851.SupplierProformasRepository>()));
    gh.factory<_i90.SuppliersProformasListBloc>(
        () => _i90.SuppliersProformasListBloc(
              gh<_i556.GetSuppliersProformasListUseCase>(),
              gh<_i851.SupplierProformasRepository>(),
              gh<_i226.DeleteSupplierProformaUseCase>(),
              gh<_i413.UpdateSupplierProformaUseCase>(),
              gh<_i598.CreateSupplierProformaUseCase>(),
            ));
    gh.lazySingleton<_i671.AddBillUseCase>(
        () => _i671.AddBillUseCase(repository: gh<_i292.BillsRepository>()));
    gh.lazySingleton<_i321.DeleteBillUseCase>(
        () => _i321.DeleteBillUseCase(repository: gh<_i292.BillsRepository>()));
    gh.lazySingleton<_i218.GetBillsListUseCase>(() =>
        _i218.GetBillsListUseCase(repository: gh<_i292.BillsRepository>()));
    gh.lazySingleton<_i372.GetBillsSummaryUseCase>(() =>
        _i372.GetBillsSummaryUseCase(repository: gh<_i292.BillsRepository>()));
    gh.lazySingleton<_i588.GetBillUseCase>(
        () => _i588.GetBillUseCase(repository: gh<_i292.BillsRepository>()));
    gh.lazySingleton<_i745.UpdateBillUseCase>(
        () => _i745.UpdateBillUseCase(repository: gh<_i292.BillsRepository>()));
    gh.factory<_i512.CustomerFormBloc>(() => _i512.CustomerFormBloc(
          gh<_i116.CreateCustomerUsecase>(),
          gh<_i134.UpdateCustomerUsecase>(),
        ));
    gh.lazySingleton<_i729.UsersListCubit>(() => _i729.UsersListCubit(
          gh<_i176.GetUsersListUseCase>(),
          gh<_i766.AddNewUserUseCase>(),
          gh<_i130.RemoveUserUseCase>(),
        ));
    gh.factory<_i363.BillFormBloc>(() => _i363.BillFormBloc(
          gh<_i671.AddBillUseCase>(),
          gh<_i745.UpdateBillUseCase>(),
        ));
    gh.lazySingleton<_i411.CreateDealBillUseCase>(() =>
        _i411.CreateDealBillUseCase(
            dealsBillsRepository: gh<_i874.DealsBillsRepository>()));
    gh.lazySingleton<_i728.GetDealsBillsListUseCase>(() =>
        _i728.GetDealsBillsListUseCase(
            dealsBillsRepository: gh<_i874.DealsBillsRepository>()));
    gh.lazySingleton<_i878.DeleteDealBillUseCase>(() =>
        _i878.DeleteDealBillUseCase(
            repository: gh<_i874.DealsBillsRepository>()));
    gh.lazySingleton<_i826.UpdateDealBillUseCase>(() =>
        _i826.UpdateDealBillUseCase(
            repository: gh<_i874.DealsBillsRepository>()));
    gh.factory<_i612.CustomersProformasListBloc>(
        () => _i612.CustomersProformasListBloc(
              gh<_i330.GetCustomersProformasListUseCase>(),
              gh<_i5.CustomersProformasRepository>(),
              gh<_i360.DeleteCustomerProformaUseCase>(),
              gh<_i42.UpdateCustomerProformaUseCase>(),
              gh<_i70.CreateCustomerProformaUseCase>(),
            ));
    gh.factory<_i839.ShippingInvoiceFormBloc>(
        () => _i839.ShippingInvoiceFormBloc(
              gh<_i163.CreateShippingInvoiceUseCase>(),
              gh<_i766.UpdateShippingInvoicesUseCase>(),
            ));
    gh.factory<_i594.DealsListBloc>(() => _i594.DealsListBloc(
          gh<_i419.GetDealsListUseCase>(),
          gh<_i343.DealsRepository>(),
          gh<_i223.DeleteDealUseCase>(),
          gh<_i473.UpdateDealUseCase>(),
          gh<_i776.CreateDealUseCase>(),
        ));
    gh.factory<_i395.DealDetailsCubit>(() => _i395.DealDetailsCubit(
          gh<_i745.GetDealUseCase>(),
          gh<_i473.UpdateDealUseCase>(),
          gh<_i223.DeleteDealUseCase>(),
        ));
    gh.factory<_i254.SupplierInvoiceFormBloc>(
        () => _i254.SupplierInvoiceFormBloc(
              gh<_i518.CreateSupplierInvoiceUseCase>(),
              gh<_i763.UpdateSupplierInvoiceUseCase>(),
            ));
    gh.factory<_i497.SuppliersListBloc>(() => _i497.SuppliersListBloc(
          gh<_i884.GetSuppliersListUsecase>(),
          gh<_i226.DeleteSupplierUsecase>(),
          gh<_i712.SuppliersRepository>(),
          gh<_i428.UpdateSupplierUsecase>(),
          gh<_i57.CreateSupplierUsecase>(),
        ));
    gh.factory<_i323.SupplierFormBloc>(() => _i323.SupplierFormBloc(
          gh<_i57.CreateSupplierUsecase>(),
          gh<_i428.UpdateSupplierUsecase>(),
        ));
    gh.factory<_i30.LoginCubit>(() => _i30.LoginCubit(
          gh<_i288.AuthRepo>(),
          gh<_i51.AppAuthBloc>(),
        ));
    gh.factory<_i792.SupplierProformaFormBloc>(
        () => _i792.SupplierProformaFormBloc(
              gh<_i598.CreateSupplierProformaUseCase>(),
              gh<_i413.UpdateSupplierProformaUseCase>(),
            ));
    gh.factory<_i813.BillsListBloc>(() => _i813.BillsListBloc(
          gh<_i218.GetBillsListUseCase>(),
          gh<_i292.BillsRepository>(),
          gh<_i321.DeleteBillUseCase>(),
          gh<_i745.UpdateBillUseCase>(),
          gh<_i671.AddBillUseCase>(),
          gh<_i372.GetBillsSummaryUseCase>(),
        ));
    gh.factory<_i144.DealBillFormBloc>(() => _i144.DealBillFormBloc(
          gh<_i411.CreateDealBillUseCase>(),
          gh<_i826.UpdateDealBillUseCase>(),
        ));
    gh.factory<_i366.DealBillsListBloc>(() => _i366.DealBillsListBloc(
          gh<_i728.GetDealsBillsListUseCase>(),
          gh<_i878.DeleteDealBillUseCase>(),
          gh<_i874.DealsBillsRepository>(),
          gh<_i826.UpdateDealBillUseCase>(),
          gh<_i411.CreateDealBillUseCase>(),
        ));
    return this;
  }
}

class _$ITMCoreInjectableModules extends _i564.ITMCoreInjectableModules {}
