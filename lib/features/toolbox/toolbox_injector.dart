import 'package:get_it/get_it.dart';
import 'data/repositories/toolbox_repository_impl.dart';
import 'domain/repositories/toolbox_repository.dart';

final gi = GetIt.instance;

void setupToolboxInjector() {
  if (!gi.isRegistered<ToolboxRepository>()) {
    gi.registerLazySingleton<ToolboxRepository>(() => ToolboxRepositoryImpl());
  }
}
