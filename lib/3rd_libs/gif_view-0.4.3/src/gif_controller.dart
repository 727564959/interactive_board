import 'package:flutter/material.dart';
import 'git_frame.dart';

enum GifStatus { loading, playing, stoped, paused, reversing, error }

class GifController extends ChangeNotifier {
  List<GifFrame> _frames = [];
  int currentIndex = 0;
  GifStatus status = GifStatus.loading;
  Exception? exception;

  final bool autoPlay;
  final VoidCallback? onFinish;
  final VoidCallback? onStart;
  final ValueChanged<int>? onFrame;

  bool loop;
  bool _inverted;
  bool reserved;

  GifController({
    this.autoPlay = true,
    this.loop = true,
    bool inverted = false,
    this.reserved = false,
    this.onStart,
    this.onFinish,
    this.onFrame,
  }) : _inverted = inverted;

  void _run() {
    switch (status) {
      case GifStatus.playing:
      case GifStatus.reversing:
        _runNextFrame();
        break;
      case GifStatus.stoped:
        onFinish?.call();
        if (!reserved) currentIndex = 0;
        break;
      case GifStatus.loading:
      case GifStatus.paused:
      case GifStatus.error:
    }
  }

  void _runNextFrame() async {
    await Future.delayed(_frames[currentIndex].duration);

    if (status == GifStatus.reversing) {
      if (currentIndex > 0) {
        currentIndex--;
      } else if (loop) {
        currentIndex = _frames.length - 1;
      } else {
        status = GifStatus.stoped;
      }
    } else {
      if (currentIndex < _frames.length - 1) {
        currentIndex++;
      } else if (loop) {
        currentIndex = 0;
      } else {
        status = GifStatus.stoped;
      }
    }

    onFrame?.call(currentIndex);
    notifyListeners();
    _run();
  }

  GifFrame get currentFrame => _frames[currentIndex];
  int get countFrames => _frames.length;
  bool get isReversing => status == GifStatus.reversing;
  bool get isPaused => status == GifStatus.stoped || status == GifStatus.paused;
  bool get isPlaying => status == GifStatus.playing;

  void play({bool? inverted, int? initialFrame}) {
    if (status == GifStatus.loading || _frames.isEmpty) return;
    _inverted = inverted ?? _inverted;

    if (status == GifStatus.stoped || status == GifStatus.paused) {
      status = _inverted ? GifStatus.reversing : GifStatus.playing;

      bool isValidInitialFrame = initialFrame != null && initialFrame > 0 && initialFrame < _frames.length - 1;

      if (isValidInitialFrame) {
        currentIndex = initialFrame;
      } else {
        currentIndex = isReversing ? _frames.length - 1 : currentIndex;
      }
      onStart?.call();
      _run();
    } else {
      status = _inverted ? GifStatus.reversing : GifStatus.playing;
    }
  }

  void stop() {
    status = GifStatus.stoped;
  }

  void pause() {
    status = GifStatus.paused;
  }

  void seek(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void configure(List<GifFrame> frames, {bool updateFrames = false}) {
    exception = null;
    _frames = frames;
    if (!updateFrames || status == GifStatus.loading) {
      status = GifStatus.stoped;
      if (autoPlay) {
        play();
      }
      notifyListeners();
    }
  }

  void error(Exception e) {
    exception = e;
    status = GifStatus.error;
    notifyListeners();
  }

  void loading() {
    status = GifStatus.loading;
    notifyListeners();
  }
}
