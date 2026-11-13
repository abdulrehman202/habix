import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class EnvConfig{
  String get url;
}

@dev
@LazySingleton(as: EnvConfig)
class DevEnvConfig implements EnvConfig{
  @override
  String get url => 'http://localhost:8000';
}

@prod
@LazySingleton(as: EnvConfig)
class ProdEnvConfig implements EnvConfig{
  @override
  String get url => 'https://habix-backend-igvi.onrender.com';
}

@module
abstract class NetworkModule{
  @lazySingleton
  Dio dio(EnvConfig config){
    final dio = Dio(
      BaseOptions(
        baseUrl: config.url,
        connectTimeout: Duration(seconds: 60),
        receiveTimeout: Duration(seconds: 60),
      )
    );

    return dio;
  }
}
