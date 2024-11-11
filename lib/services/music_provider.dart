import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MusicProvider with ChangeNotifier {
  bool _isMusa = false;

  bool get isMusa => _isMusa;

  final _audioPlayer = AudioPlayer();

  void _ballbgfdouchSound() async {
    await _audioPlayer.play(AssetSource('audio/dlin.mp3'), volume: 0.5);
  }

  void st() async {
    await _audioPlayer.stop();
  }

  void togs() async {
    if (_audioPlayer.state == PlayerState.playing) {
      _isMusa = false;
      st();
    } else {
      _isMusa = true;
      _ballbgfdouchSound();
    }
    notifyListeners();
  }
}
