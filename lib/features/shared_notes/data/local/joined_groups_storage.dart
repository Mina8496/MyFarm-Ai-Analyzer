import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myfarm/features/shared_notes/domain/entities/joined_group_entity.dart';

class JoinedGroupModel extends JoinedGroupEntity {
  const JoinedGroupModel({required super.id, required super.name});

  Map<String, dynamic> toMap() => {'id': id, 'name': name};

  factory JoinedGroupModel.fromMap(Map<String, dynamic> map) => JoinedGroupModel(
        id: map['id'] as String,
        name: (map['name'] as String?)?.trim().isNotEmpty == true
            ? map['name'] as String
            : 'مجموعة بدون اسم',
      );
}

class JoinedGroupsLocalDataSource {
  static const _key = 'joined_note_groups';

  Future<List<JoinedGroupModel>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null || raw.isEmpty) return [];
    try {
      final list = jsonDecode(raw) as List;
      return list.map((e) => JoinedGroupModel.fromMap(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> upsert(JoinedGroupModel group) async {
    final prefs = await SharedPreferences.getInstance();
    final groups = await getAll();
    groups.removeWhere((g) => g.id == group.id);
    groups.insert(0, group);
    await prefs.setString(_key, jsonEncode(groups.map((g) => g.toMap()).toList()));
  }

  Future<void> remove(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final groups = await getAll();
    groups.removeWhere((g) => g.id == id);
    await prefs.setString(_key, jsonEncode(groups.map((g) => g.toMap()).toList()));
  }
}