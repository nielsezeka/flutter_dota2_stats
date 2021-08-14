import 'package:get_it/get_it.dart';
import 'graphql_dota/graphql_dota.dart';
import './service_index.dart';

class ServiceFacade {
  static final _getIt = GetIt.instance;
  static final _graphQL = DotaGraph();
  static registerDefaultService() {
    _getIt.registerSingleton<DotaGraph>(_graphQL);
  }

  static getService<T extends Object>() {
    return _getIt.get<T>();
  }
}
