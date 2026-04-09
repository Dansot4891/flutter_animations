import 'package:flutter/scheduler.dart';

/// Ticker를 사용해 1초간 프레임 타임을 측정하고,
/// 측정된 평균 프레임 타임에 따라 적응형 duration을 반환하는 유틸리티
class FrameTimeMeasurer {
  FrameTimeMeasurer({required TickerProvider vsync}) : _vsync = vsync;

  final TickerProvider _vsync;

  Ticker? _ticker;
  final List<Duration> _frameTimes = [];
  Duration? _lastTimestamp;

  /// 1초간 프레임 타임을 측정한 뒤, 적응형 duration(ms)을 반환
  Future<int> measure({
    Duration samplingDuration = const Duration(seconds: 1),
  }) async {
    _frameTimes.clear();
    _lastTimestamp = null;

    _ticker = _vsync.createTicker((Duration elapsed) {
      if (_lastTimestamp != null) {
        final frameTime = elapsed - _lastTimestamp!;
        _frameTimes.add(frameTime);
      }
      _lastTimestamp = elapsed;
    });

    _ticker!.start();

    // samplingDuration 동안 측정
    await Future.delayed(samplingDuration);

    _ticker!.stop();
    _ticker!.dispose();
    _ticker = null;

    return _calculateAdaptiveDuration();
  }

  /// 측정된 프레임 타임을 분석하여 적응형 duration 결정
  int _calculateAdaptiveDuration() {
    if (_frameTimes.isEmpty) return 2000;

    // 상위/하위 10% 제거 (아웃라이어 방지)
    final sorted = List<Duration>.from(_frameTimes)
      ..sort((a, b) => a.compareTo(b));
    final trimCount = (sorted.length * 0.1).floor();
    final trimmed = sorted.sublist(trimCount, sorted.length - trimCount);

    if (trimmed.isEmpty) return 2000;

    final avgMicroseconds =
        trimmed.map((d) => d.inMicroseconds).reduce((a, b) => a + b) /
            trimmed.length;
    final avgMs = avgMicroseconds / 1000;

    // 평균 프레임 타임에 따라 duration 분기
    //
    // | 평균 프레임 타임 | FPS 환산  | 적용 duration | 대상 기기 예시       |
    // |-----------------|----------|--------------|-------------------|
    // | < 18ms          | 55fps+   | 2000ms       | Galaxy S22+, iPhone |
    // | 18 ~ 25ms       | 40~55fps | 3000ms       | 중급 Android        |
    // | 25 ~ 40ms       | 25~40fps | 5000ms       | 보급형 Android      |
    // | > 40ms          | 25fps 미만| 8000ms       | XCover5 등 저사양   |

    if (avgMs < 18) {
      return 2000;
    } else if (avgMs < 25) {
      return 3000;
    } else if (avgMs < 40) {
      return 5000;
    } else {
      return 8000;
    }
  }

  /// 측정된 평균 프레임 타임 (ms) - 디버깅/표시용
  double get measuredAvgFrameTimeMs {
    if (_frameTimes.isEmpty) return 0;
    final sorted = List<Duration>.from(_frameTimes)
      ..sort((a, b) => a.compareTo(b));
    final trimCount = (sorted.length * 0.1).floor();
    final trimmed = sorted.sublist(trimCount, sorted.length - trimCount);
    if (trimmed.isEmpty) return 0;
    return trimmed.map((d) => d.inMicroseconds).reduce((a, b) => a + b) /
        trimmed.length /
        1000;
  }

  /// 측정된 프레임 수 - 디버깅/표시용
  int get measuredFrameCount => _frameTimes.length;

  void dispose() {
    _ticker?.stop();
    _ticker?.dispose();
    _ticker = null;
  }
}
