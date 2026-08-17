import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../../../toolbox_injector.dart';
import '../../../domain/repositories/toolbox_repository.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  final AudioPlayer _player = AudioPlayer();
  late final ToolboxRepository _repo;
  List<PlatformFile> _files = [];
  String? _radioUrl;

  @override
  void initState() {
    super.initState();
    setupToolboxInjector();
    _repo = gi<ToolboxRepository>();
    _loadTracks();
  }

  Future<void> _loadTracks() async {
    final paths = await _repo.getTracks();
    setState(() {
      _files = paths
          .map(
            (p) => PlatformFile(
              name: p.split(Platform.pathSeparator).last,
              path: p,
              size: 0,
            ),
          )
          .toList();
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _pickFiles() async {
    final res = await FilePicker.pickFiles(
      type: FileType.audio,
      allowMultiple: true,
    );

    if (res != null && res.files.isNotEmpty) {
      setState(() => _files.addAll(res.files));
      for (final f in res.files) {
        if (f.path != null) await _repo.addTrack(f.path!);
      }
    }
  }

  Future<void> _playFile(PlatformFile file) async {
    try {
      await _player.setFilePath(file.path!);
      _player.play();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('خطأ بتشغيل الملف')));
    }
  }

  Future<void> _playRadio() async {
    if (_radioUrl == null || _radioUrl!.isEmpty) return;
    try {
      await _player.setUrl(_radioUrl!);
      _player.play();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('خطأ بتشغيل البث')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الموسيقى')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'رابط راديو (URL)',
                    ),
                    onChanged: (v) => _radioUrl = v,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.play_arrow),
                  onPressed: _playRadio,
                ),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _pickFiles,
              icon: const Icon(Icons.folder_open),
              label: const Text('اختر ملفات صوتية'),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _files.isEmpty
                  ? const Center(child: Text('لم يتم اختيار ملفات'))
                  : ListView.builder(
                      itemCount: _files.length,
                      itemBuilder: (context, i) {
                        final f = _files[i];
                        return ListTile(
                          leading: const Icon(Icons.music_note),
                          title: Text(f.name),
                          subtitle: Text(
                            '${(f.size / 1024).toStringAsFixed(1)} KB',
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.play_arrow),
                            onPressed: () => _playFile(f),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
