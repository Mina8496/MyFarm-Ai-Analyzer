
import 'package:myfarm/features/ambient_screen/domain/repositories/ambient_repository.dart';

class CloseAmbientScreen {
  final AmbientRepository repository;

  CloseAmbientScreen(this.repository);

  Future<void> call() {
    return repository.closeScreen();
  }
}