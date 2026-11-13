// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'core/Network/env_config.dart' as _i574;
import 'data/datasource/habit/local_datasource.dart' as _i1059;
import 'data/datasource/habit/remote_datasource.dart' as _i1063;
import 'data/datasource/userAuth/remote_datasource.dart' as _i262;
import 'data/datasource/userProfile/local_datasource.dart' as _i450;
import 'data/datasource/userProfile/remote_datasource.dart' as _i368;
import 'data/repositories/habits_repository_imp.dart' as _i889;
import 'data/repositories/user_auth_imp.dart' as _i293;
import 'data/repositories/user_profile_imp.dart' as _i684;
import 'domain/repositories/habit_repository.dart' as _i151;
import 'domain/repositories/user_auth_repository.dart' as _i663;
import 'domain/repositories/user_profile_repository.dart' as _i689;
import 'domain/usecase/habit_usecases.dart' as _i389;
import 'domain/usecase/user_auth_usecases.dart' as _i358;
import 'domain/usecase/user_profile_usecases.dart' as _i43;

const String _dev = 'dev';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i1059.HabitLocalDataSource>(
      () => _i1059.HabitLocalDataSourceImp(),
    );
    gh.lazySingleton<_i450.UserProfileLocalDataSource>(
      () => _i450.UserProfileLocalDataSourceImp(),
    );
    gh.lazySingleton<_i574.EnvConfig>(
      () => _i574.DevEnvConfig(),
      registerFor: {_dev},
    );
    gh.lazySingleton<_i574.EnvConfig>(
      () => _i574.ProdEnvConfig(),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio(gh<_i574.EnvConfig>()));
    gh.lazySingleton<_i262.UserAuthRemoteDataSource>(
      () => _i262.UserAuthRemoteDataSourceImp(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i368.UserProfileRemoteDataSource>(
      () => _i368.UserProfileRemoteDataSourceImp(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i1063.HabitRemoteDataSource>(
      () => _i1063.HabitRemoteDataSourceImp(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i689.UserProfileRespository>(
      () => _i684.UserProfileRepositoryImp(
        gh<_i368.UserProfileRemoteDataSource>(),
        gh<_i450.UserProfileLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i151.HabitRepository>(
      () => _i889.HabitRepositoryImpl(
        gh<_i1059.HabitLocalDataSource>(),
        gh<_i1063.HabitRemoteDataSource>(),
      ),
    );
    gh.factory<_i43.UserProfileUsecases>(
      () => _i43.UserProfileUsecases(gh<_i689.UserProfileRespository>()),
    );
    gh.lazySingleton<_i663.UserAuthRepository>(
      () => _i293.UserAuthRepositoryImp(gh<_i262.UserAuthRemoteDataSource>()),
    );
    gh.factory<_i358.UserAuthUsecases>(
      () => _i358.UserAuthUsecases(gh<_i663.UserAuthRepository>()),
    );
    gh.factory<_i389.HabitUsecases>(
      () => _i389.HabitUsecases(gh<_i151.HabitRepository>()),
    );
    return this;
  }
}

class _$NetworkModule extends _i574.NetworkModule {}
