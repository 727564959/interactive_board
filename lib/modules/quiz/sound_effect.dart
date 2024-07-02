import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SoundEffect {
  final player = AudioPlayer();
  AssetSource getAudioSource(String soundFile) {
    return AssetSource("sound_effects/quiz/$soundFile");
  }

  void coverLogoPlay() {
    player.play(getAudioSource("cover_logo.wav"));
  }

  void joinPagePlay() {
    player.play(getAudioSource("join_page.wav"));
  }

  void clickPlay() {
    player.play(getAudioSource("click.wav"));
  }

  void questionPlay() {
    player.play(getAudioSource("question.wav"));
  }

  void questionTypePlay() {
    player.play(getAudioSource("question_type.wav"));
  }

  void rightPlay() {
    player.play(getAudioSource("right.wav"));
  }

  void wrongPlay() {
    player.play(getAudioSource("wrong.wav"));
  }

  void dispose() {
    player.dispose();
  }
}
