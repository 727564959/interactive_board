import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:soundpool/soundpool.dart';

class SoundEffect {
  final Soundpool _pool = Soundpool.fromOptions();
  late final int _coverLogoSoundId;
  late final int _joinPageSoundId;
  late final int _clickSoundId;
  late final int _questionSoundId;
  late final int _questionTypeSoundId;
  late final int _rightSoundId;
  late final int _wrongSoundId;
  Future<int> loadSoundEffect(String soundFile) async {
    ByteData soundData = await rootBundle.load("assets/sound_effects/quiz/$soundFile");
    return await _pool.load(soundData);
  }

  Future<void> load() async {
    _coverLogoSoundId = await loadSoundEffect("cover_logo.wav");
    _joinPageSoundId = await loadSoundEffect("join_page.wav");
    _clickSoundId = await loadSoundEffect("click.wav");
    _questionSoundId = await loadSoundEffect("question.wav");
    _questionTypeSoundId = await loadSoundEffect("question_type.wav");
    _rightSoundId = await loadSoundEffect("right.wav");
    _wrongSoundId = await loadSoundEffect("wrong.wav");
  }

  void coverLogoPlay() {
    _pool.play(_coverLogoSoundId, rate: 1.7);
  }

  void joinPagePlay() {
    _pool.play(_joinPageSoundId);
  }

  void clickPlay() {
    _pool.play(_clickSoundId);
  }

  void questionPlay() {
    _pool.play(_questionSoundId);
  }

  void questionTypePlay() {
    _pool.play(_questionTypeSoundId);
  }

  void rightPlay() {
    _pool.play(_rightSoundId);
  }

  void wrongPlay() {
    _pool.play(_wrongSoundId);
  }

  void dispose() {
    _pool.release();
  }
}
