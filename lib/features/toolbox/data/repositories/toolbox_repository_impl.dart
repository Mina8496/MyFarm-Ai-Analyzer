import '../../domain/repositories/toolbox_repository.dart';

class ToolboxRepositoryImpl implements ToolboxRepository {
  final List<DateTime> _alarms = [];
  final List<String> _tracks = [];

  @override
  Future<void> addAlarm(DateTime time) async {
    _alarms.add(time);
  }

  @override
  Future<void> removeAlarm(DateTime time) async {
    _alarms.remove(time);
  }

  @override
  Future<List<DateTime>> getAlarms() async => List.unmodifiable(_alarms);

  @override
  Future<void> addTrack(String path) async => _tracks.add(path);

  @override
  Future<List<String>> getTracks() async => List.unmodifiable(_tracks);
}
