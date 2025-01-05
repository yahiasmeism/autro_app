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
import 'package:autro_app/features/authentication/bloc/app_auth/app_auth_bloc.dart' as _i51;
import 'package:autro_app/features/authentication/bloc/login/login_cubit.dart' as _i30;
import 'package:autro_app/features/authentication/bloc/register/register_cubit.dart' as _i173;
import 'package:autro_app/features/authentication/data/data_sources/auth_remote_data_source.dart' as _i388;
import 'package:autro_app/features/authentication/data/repo/auth_repo.dart' as _i288;
import 'package:autro_app/features/customers/data/datasources/customers_remote_datesourse.dart' as _i438;
import 'package:autro_app/features/customers/data/repositories/customers_repository_impl.dart' as _i388;
import 'package:autro_app/features/customers/domin/repositories/customers_repository.dart' as _i54;
import 'package:autro_app/features/customers/domin/usecases/create_customer_usecase.dart' as _i116;
import 'package:autro_app/features/customers/domin/usecases/delete_customer_usecase.dart' as _i207;
import 'package:autro_app/features/customers/domin/usecases/get_customer_usecase.dart' as _i832;
import 'package:autro_app/features/customers/domin/usecases/get_customers_list_usecase.dart' as _i486;
import 'package:autro_app/features/customers/domin/usecases/update_customer_usecase.dart' as _i134;

import 'package:autro_app/features/customers/presentation/bloc/customer_form/customer_form_bloc.dart' as _i512;
import 'package:autro_app/features/customers/presentation/bloc/customers_list/customers_list_bloc.dart' as _i815;
import 'package:autro_app/features/home/bloc/home_bloc.dart' as _i80;
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
    gh.lazySingleton<_i80.HomeBloc>(() => _i80.HomeBloc());
    gh.lazySingleton<_i646.NetworkInfo>(() => _i646.NetworkInfoImpl());
    gh.lazySingleton<_i123.AppPreferences>(() => _i123.AppPreferencesImpl(sharedPreferences: gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i228.ApiClient>(() => _i228.DioClient(gh<_i123.AppPreferences>()));
    gh.lazySingleton<_i438.CustomersRemoteDataSource>(
        () => _i438.CustomersRemoteDataSourceImpl(apiClient: gh<_i228.ApiClient>()));
    gh.lazySingleton<_i388.AuthRemoteDataSource>(() => _i388.AuthRemoteDataSourceImpl(apiClient: gh<_i228.ApiClient>()));
    gh.lazySingleton<_i288.AuthRepo>(() => _i288.AuthRepoImpl(
          remoteDataSource: gh<_i388.AuthRemoteDataSource>(),
          appPreferences: gh<_i123.AppPreferences>(),
          networkInfo: gh<_i646.NetworkInfo>(),
        ));
    gh.lazySingleton<_i54.CustomersRepository>(() => _i388.CustomersRepositoryImpl(
          remoteDataSource: gh<_i438.CustomersRemoteDataSource>(),
          networkInfo: gh<_i646.NetworkInfo>(),
        ));
    gh.lazySingleton<_i116.CreateCustomerUsecase>(
        () => _i116.CreateCustomerUsecase(customersRepository: gh<_i54.CustomersRepository>()));
    gh.lazySingleton<_i207.DeleteCustomerUsecase>(
        () => _i207.DeleteCustomerUsecase(customersRepository: gh<_i54.CustomersRepository>()));
    gh.lazySingleton<_i486.GetCustomersListUsecase>(
        () => _i486.GetCustomersListUsecase(customersRepository: gh<_i54.CustomersRepository>()));
    gh.lazySingleton<_i832.GetCustomerUsecase>(
        () => _i832.GetCustomerUsecase(customersRepository: gh<_i54.CustomersRepository>()));
    gh.lazySingleton<_i134.UpdateCustomerUsecase>(
        () => _i134.UpdateCustomerUsecase(customersRepository: gh<_i54.CustomersRepository>()));
    gh.factory<_i30.LoginCubit>(() => _i30.LoginCubit(gh<_i288.AuthRepo>()));
    gh.factory<_i173.RegisterCubit>(() => _i173.RegisterCubit(gh<_i288.AuthRepo>()));
    gh.lazySingleton<_i51.AppAuthBloc>(() => _i51.AppAuthBloc(gh<_i288.AuthRepo>()));
    gh.lazySingleton<_i815.CustomersListBloc>(() => _i815.CustomersListBloc(
          gh<_i486.GetCustomersListUsecase>(),
          gh<_i54.CustomersRepository>(),
          gh<_i207.DeleteCustomerUsecase>(),
          gh<_i134.UpdateCustomerUsecase>(),
          gh<_i116.CreateCustomerUsecase>(),
        ));
    gh.factory<_i512.CustomerFormBloc>(() => _i512.CustomerFormBloc(
          gh<_i116.CreateCustomerUsecase>(),
          gh<_i134.UpdateCustomerUsecase>(),
          gh<_i815.CustomersListBloc>(),
        ));
    return this;
  }
}

class _$ITMCoreInjectableModules extends _i564.ITMCoreInjectableModules {}
