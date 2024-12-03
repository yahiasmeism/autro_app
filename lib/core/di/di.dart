import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

final sl = GetIt.instance;

@injectableInit
Future<void> configureInjection(String env) async {
  await sl.init(environment: env);
}
