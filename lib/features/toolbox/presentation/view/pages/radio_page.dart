import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:myfarm/features/toolbox/data/model/radio_station.dart';

class RadioPage extends StatefulWidget {
  const RadioPage({super.key});

  @override
  State<RadioPage> createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  final AudioPlayer _player = AudioPlayer();
  RadioStation? _currentStation;
  bool _isPlaying = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _playStation(RadioStation station) async {
    if (_currentStation?.streamUrl == station.streamUrl && _isPlaying) {
      await _player.stop();
      setState(() => _isPlaying = false);
      return;
    }

    setState(() {
      _currentStation = station;
      _isLoading = true;
      _isPlaying = false;
    });

    try {
      await _player.setAudioSource(
        AudioSource.uri(
          Uri.parse(station.streamUrl),
          tag: MediaItem(
            id: station.streamUrl,
            title: station.name,
            artist: 'راديو مباشر',
            artUri: Uri.parse(
              station.logoUrl,
            ), // لازم يكون رابط نت مش asset محلي
          ),
        ),
      );
      _player.play();
      setState(() {
        _isPlaying = true;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('تعذر تشغيل ${station.name}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الراديو')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemCount: stations.length,
          itemBuilder: (context, index) {
            final station = stations[index];
            final isActive = _currentStation?.streamUrl == station.streamUrl;
            final isThisPlaying = isActive && _isPlaying;
            final isThisLoading = isActive && _isLoading;

            return GestureDetector(
              onTap: () => _playStation(station),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isThisPlaying
                        ? Colors.deepPurple
                        : Colors.grey.shade300,
                    width: isThisPlaying ? 2 : 1,
                  ),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.deepPurple.shade50,
                          backgroundImage: AssetImage(station.logoUrl),
                        ),
                        if (isThisLoading)
                          const SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      station.name,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Icon(
                      isThisPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
                      color: isThisPlaying ? Colors.deepPurple : Colors.grey,
                      size: 20,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
