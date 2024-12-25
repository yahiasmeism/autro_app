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
import 'package:autro_app/features/authentication/data/data_sources/auth_remote_data_source.dart'
    as _i388;
import 'package:autro_app/features/authentication/data/repo/auth_repo.dart'
    as _i288;
import 'package:autro_app/features/authentication/bloc/app_auth/app_auth_bloc.dart'
    as _i353;
import 'package:autro_app/features/authentication/bloc/login/login_cubit.dart'
    as _i878;
import 'package:autro_app/features/authentication/bloc/register/register_cubit.dart'
    as _i744;
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
    gh.lazySingleton<_i123.AppPreferences>(() => _i123.AppPreferencesImpl(
        sharedPreferences: gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i228.ApiClient>(
        () => _i228.DioClient(gh<_i123.AppPreferences>()));
    gh.lazySingleton<_i388.AuthRemoteDataSource>(
        () => _i388.AuthRemoteDataSourceImpl(apiClient: gh<_i228.ApiClient>()));
    gh.lazySingleton<_i288.AuthRepo>(() => _i288.AuthRepoImpl(
          remoteDataSource: gh<_i388.AuthRemoteDataSource>(),
          appPreferences: gh<_i123.AppPreferences>(),
          networkInfo: gh<_i646.NetworkInfo>(),
        ));
    gh.factory<_i878.LoginCubit>(() => _i878.LoginCubit(gh<_i288.AuthRepo>()));
    gh.factory<_i744.RegisterCubit>(
        () => _i744.RegisterCubit(gh<_i288.AuthRepo>()));
    gh.lazySingleton<_i353.AppAuthBloc>(
        () => _i353.AppAuthBloc(gh<_i288.AuthRepo>()));
    return this;
  }
}

class _$ITMCoreInjectableModules extends _i564.ITMCoreInjectableModules {}
