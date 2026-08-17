abstract class ToolboxRepository {
  Future<List<DateTime>> getAlarms();
  Future<void> addAlarm(DateTime time);
  Future<void> removeAlarm(DateTime time);

  Future<List<String>> getTracks();
  Future<void> addTrack(String path);
}
