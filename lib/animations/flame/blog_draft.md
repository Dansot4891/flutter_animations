안녕하세요. 오늘은 실무에서 동일한 애니메이션 코드가 Galaxy S22+에서는 부드럽게 동작하는데, Galaxy XCover5 같은 저사양 기기에서는 완전히 다르게 보이는 경험을 했습니다. 이 글에서는 그 원인을 분석하고, 기기 성능에 맞춰 애니메이션을 적응시키는 방법을 공유하려고합니다.


# 1. 문제 상황

위젯이 위아래로 부드럽게 점프하는 애니메이션을 만들었습니다. `controller.forward()`로 올라가고, `controller.reverse()`로 내려오는 걸 반복하는 단순한 구조입니다.

```dart
for (int i = 0; i < repeatCount; i++) {
  await controller.forward();
  await controller.reverse();
}
```

이 코드가 고사양 기기에서는 의도한 대로 부드럽게 동작했습니다. 그런데 저사양 Android 기기에서 실행하니:

- 같은 코드인데 애니메이션이 **비정상적으로 빠르게 왔다갔다**함
- duration을 500ms로 설정했는데, 체감상 훨씬 짧은 시간 안에 여러 번 왕복
- 부드러운 곡선이 아니라, 위-아래-위-아래를 빠르게 반복하는 느낌

처음에는 "기기가 느리니까 애니메이션도 느리겠지"라고 생각했는데, 오히려 **반대**였습니다. 느린 기기에서 애니메이션이 더 빨라 보이는 역설적인 현상이었고, 이건 Flutter `AnimationController`의 동작 방식에서 비롯된 문제였습니다.


---

# 2. 핵심 개념 정리

원인을 이해하려면 다음과 같은 개념을 먼저 알아야 합니다.

## 2-1. Wall-clock time

![](https://velog.velcdn.com/images/mw000724/post/c1849f1f-b046-4260-8893-3f3e29f45575/image.png)


Flutter의 `AnimationController`는 "프레임 수"가 아니라 **"실제 경과 시간"**을 기준으로 `value`를 계산합니다.

`duration`을 500ms로 설정하면, 기기 성능과 무관하게 **정확히 500ms 후에 value가 1.0에 도달**합니다. 60fps 기기든 10fps 기기든 상관없이요.

이게 왜 중요하냐면 — 기기가 느려서 프레임을 적게 그리더라도, AnimationController는 시간이 흘렀으니 value를 크게 점프시킵니다. "부드럽게 중간 값을 다 거쳐가는 것"이 아니라 **"시간에 맞춰 현재 있어야 할 위치로 바로 이동"**하는 거죠.

## 2-2. Ticker와 프레임 타임

![](https://velog.velcdn.com/images/mw000724/post/ed772533-c6cb-4490-ba18-eb2f4fb11a3d/image.png)

`Ticker`는 Flutter 엔진이 매 프레임마다 호출하는 콜백입니다. `AnimationController`도 내부적으로 `Ticker`를 사용합니다.

여기서 **프레임 타임**이란, Ticker 콜백 사이의 시간 간격을 말합니다.

| 기기 성능 | 프레임 타임 | FPS 환산 |
|----------|-----------|---------|
| 고사양 | ~16.6ms | 60fps |
| 중급 | ~25ms | 40fps |
| 저사양 | ~33.3ms | 30fps |
| 매우 저사양 | 40ms 이상 | 25fps 미만 |

이 프레임 타임이 클수록, 기기가 한 프레임을 렌더링하는 데 오래 걸린다는 뜻입니다. 그리고 이 값을 **런타임에 Ticker로 직접 측정할 수 있습니다.** 이게 이 글의 핵심 아이디어입니다.


---

# 3. 원인 분석

![](https://velog.velcdn.com/images/mw000724/post/a54a7961-cbb0-45aa-bff0-50c80690e666/image.png)

이제 위 개념을 조합해서, 왜 저사양 기기에서 애니메이션이 빨라지는지 구체적으로 확인해보겠습니다.

duration 500ms짜리 위아래 점프 애니메이션을 예로 들겠습니다.

## 고사양 기기 (60fps)

`forward()` 한 번에 약 **30프레임**이 그려집니다.

```
value: 0.00 → 0.03 → 0.07 → 0.10 → ... → 0.93 → 0.97 → 1.00
       ↑ forward() 완료, reverse() 시작
value: 1.00 → 0.97 → 0.93 → ... → 0.07 → 0.03 → 0.00
       ↑ reverse() 완료, 다음 루프
```

30단계에 걸쳐 위치가 조금씩 바뀌고, `forward()`가 끝나면 `reverse()`가 시작됩니다. 한 사이클(올라갔다 내려옴)에 약 1초, 사람 눈에는 부드러운 곡선 움직임으로 보입니다.

## 저사양 기기 (프레임 드랍 발생)

같은 500ms duration이지만, 프레임 드랍으로 **5~8프레임** 만에 `forward()`가 끝납니다.

```
value: 0.0 → 0.15 → 0.4 → 0.7 → 0.95 → 1.0
       ↑ forward() 완료! 바로 reverse() 시작
value: 1.0 → 0.8 → 0.5 → 0.2 → 0.0
       ↑ reverse() 완료! 바로 다음 루프
```

여기서 핵심은 **wall-clock time 기반이라 500ms가 지나면 `forward()`의 Future가 바로 완료된다**는 점입니다. 고사양에서 30프레임에 걸쳐 부드럽게 보이던 과정이, 저사양에서는 5프레임 만에 끝나버립니다.

문제는 `await controller.forward()` → `await controller.reverse()` 루프와 결합될 때 드러납니다.

고사양 기기에서는 `forward()`가 30프레임에 걸쳐 부드럽게 완료되고, 사용자는 그 과정을 눈으로 따라갈 수 있습니다. 하지만 저사양 기기에서는 5프레임 만에 `forward()`가 끝나고, 바로 `reverse()`가 시작되고, 그것도 5프레임 만에 끝나고, 바로 다음 루프가 시작됩니다.

**사용자 눈에는 이렇게 보입니다:**
- 고사양: 위로 ~~스르륵~~ → 아래로 ~~스르륵~~ (1초에 1번 왕복)
- 저사양: 위! 아래! 위! 아래! 위! 아래! (중간 과정이 안 보이니 빠르게 왕복하는 것처럼 느껴짐)

Duration은 500ms로 동일합니다. 하지만 중간 프레임이 부족해서 **부드러운 움직임이 빠른 왕복으로 변해버린 겁니다.**

## 정리

| | 고사양 (60fps) | 저사양 (프레임 드랍) |
|---|---|---|
| duration | 500ms | 500ms (동일) |
| forward() 프레임 수 | ~30 | ~5~8 |
| 프레임당 value 변화 | ~0.03 | 0.1~0.25 |
| 체감 | 부드러운 곡선 | 빠르게 왔다갔다 |


---

# 4. 해결 아이디어

발상은 생각보다 간단합니다.

> 프레임이 부족해서 빠르게 보인다면, **duration을 늘려서 더 많은 프레임에 걸쳐 재생**되게 하자.

![](https://velog.velcdn.com/images/mw000724/post/acc9bf6c-5782-4867-ba27-cb7de2c39f68/image.png)

duration이 500ms일 때 저사양에서 5프레임 만에 끝나던 것을, duration을 8000ms로 늘리면 같은 프레임 드랍 환경에서도 **훨씬 많은 프레임**에 걸쳐 재생됩니다. 프레임당 value 변화량도 줄어들어 점프가 작아지고요.

애니메이션은 느려지지만, 빠르게 왔다갔다하는 것보다 느리더라도 부드러운 움직임이 **사용자 경험 면에서 훨씬 낫습니다.**

문제는 "이 기기가 얼마나 느린지"를 어떻게 아느냐인데 저는 앱 시작 시 Ticker로 **실제 프레임 타임을 1초간 측정**하도록 설정하였습니다. 측정 결과에 따라 duration을 단계별로 늘려주는 겁니다.

| 평균 프레임 타임 | FPS 환산 | 적용 duration | 대상 기기 예시 |
|---|---|---|---|
| ≤ 20ms | 50fps+ | 500ms (기본) | Galaxy S22+, iPhone |
| 20 ~ 40ms | 25~50fps | 1000ms | 중급 Android |
| > 40ms | 25fps 미만 | 8000ms | XCover5 등 저사양 |


---

# 5. 구현

전체 구현을 단계별로 살펴보겠습니다.

## 1단계: 프레임 타임 측정기 

먼저 기기의 프레임 처리 능력을 측정하는 유틸리티 클래스입니다.

```dart
import 'package:flutter/scheduler.dart';

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
    await Future.delayed(samplingDuration);
    _ticker!.stop();
    _ticker!.dispose();
    _ticker = null;

    return _calculateAdaptiveDuration();
  }

  int _calculateAdaptiveDuration() {
    if (_frameTimes.isEmpty) return 500;

    // 상위/하위 10% 제거 (아웃라이어 방지)
    final sorted = List<Duration>.from(_frameTimes)
      ..sort((a, b) => a.compareTo(b));
    final trimCount = (sorted.length * 0.1).floor();
    final trimmed = sorted.sublist(trimCount, sorted.length - trimCount);

    if (trimmed.isEmpty) return 500;

    final avgMicroseconds =
        trimmed.map((d) => d.inMicroseconds).reduce((a, b) => a + b) /
            trimmed.length;
    final avgMs = avgMicroseconds / 1000;

    // 평균 프레임 타임에 따라 duration 분기
    if (avgMs <= 20) {
      return 500;    // 50fps 이상: 기본 duration
    } else if (avgMs <= 40) {
      return 1000;   // 25~50fps: 2배
    } else {
      return 8000;   // 25fps 미만: 대폭 보정
    }
  }

  void dispose() {
    _ticker?.stop();
    _ticker?.dispose();
    _ticker = null;
  }
}
```

`createTicker`의 콜백은 매 프레임마다 호출됩니다. 이전 타임스탬프와의 차이를 `_frameTimes`에 쌓으면, 1초 후에는 기기의 실제 프레임 처리 능력을 나타내는 데이터가 모입니다.

`_calculateAdaptiveDuration()`에서 상하위 10%를 잘라내는 이유는, 앱 시작 직후 다른 초기화 작업 때문에 프레임 타임이 튀는 경우가 있기 때문입니다. Trimmed mean을 사용하면 이런 노이즈를 줄일 수 있습니다.

### 2단계: 점프 애니메이션 위젯

위아래로 반복 점프하는 위젯입니다. `durationMs`를 외부에서 받아서 AnimationController에 적용합니다.

```dart
import 'package:flutter/material.dart';

class JumpUpAnimation extends StatefulWidget {
  const JumpUpAnimation({
    super.key,
    required this.durationMs,
    required this.label,
    required this.color,
  });

  final int durationMs;
  final String label;
  final Color color;

  @override
  State<JumpUpAnimation> createState() => _JumpUpAnimationState();
}

class _JumpUpAnimationState extends State<JumpUpAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _jumpAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  void _setupAnimation() {
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.durationMs),
      vsync: this,
    );

    _jumpAnimation = Tween<double>(begin: 0, end: -60).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(JumpUpAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.durationMs != widget.durationMs) {
      _controller.dispose();
      _setupAnimation();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.label,
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        const SizedBox(height: 2),
        Text('${widget.durationMs}ms',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: widget.color)),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: AnimatedBuilder(
            animation: _jumpAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _jumpAnimation.value),
                child: child,
              );
            },
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_upward,
                  color: Colors.white, size: 24),
            ),
          ),
        ),
      ],
    );
  }
}
```

핵심은 `durationMs`를 외부에서 주입받는다는 점입니다. 고정값이 아니라 측정 결과에 따라 달라지는 값을 받으면, 같은 위젯이 기기 성능에 맞게 동작합니다.

### 3단계: 측정 + 비교 페이지 

위 두 클래스를 조합해서, 적용 전/후를 나란히 비교하는 페이지입니다.

```dart
import 'package:flutter/material.dart';

class AdaptiveAnimationPage extends StatelessWidget {
  const AdaptiveAnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adaptive Animation')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 적용 전: 같은 duration인데 B기기에서 빠르게 왔다갔다
            const Text('적용 전',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            const SizedBox(height: 4),
            Text('같은 코드인데 B기기에서는 빠르게 왔다갔다',
                style: TextStyle(
                    fontSize: 12, color: Colors.grey[600]),
                textAlign: TextAlign.center),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: JumpUpAnimation(
                    durationMs: 2000,        // 고사양 체감
                    label: 'A기기 (고사양)',
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: JumpUpAnimation(
                    durationMs: 400,         // 저사양 체감 (빠르게 왕복)
                    label: 'B기기 (저사양)',
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            // 적용 후: duration 적응으로 비슷한 체감
            const Text('적용 후',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            const SizedBox(height: 4),
            Text('duration 적응으로 두 기기의 체감 속도가 비슷해짐',
                style: TextStyle(
                    fontSize: 12, color: Colors.grey[600]),
                textAlign: TextAlign.center),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: JumpUpAnimation(
                    durationMs: 2000,
                    label: 'A기기 (고사양)',
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: JumpUpAnimation(
                    durationMs: 2000,        // 적응형 duration 적용
                    label: 'B기기 (저사양)',
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

적용 전에는 B기기(저사양)의 duration이 400ms로, 빠르게 왔다갔다하는 체감을 재현합니다. 적용 후에는 측정 결과에 따라 duration이 조정되어 A기기와 비슷한 속도로 동작합니다.

실제 프로젝트에서는 `AdaptiveAnimationPage`의 `initState`에서 `FrameTimeMeasurer.measure()`를 호출하고, 그 결과를 `JumpUpAnimation`의 `durationMs`로 넘겨주는 구조입니다.

---

# 6. 적용 전/후 비교

![](https://velog.velcdn.com/images/mw000724/post/9192fb8e-b5f8-4208-86ad-2bd6c0bab289/image.gif)


**적용 전 (고정 duration 500ms)**
- A기기 (고사양): 부드럽게 점프 ✅
- B기기 (저사양): 빠르게 왔다갔다 ❌

**적용 후 (적응형 duration)**
- A기기 (고사양): 500ms → 그대로 부드럽게 ✅
- B기기 (저사양): 8000ms → 느리지만 부드럽게, A와 비슷한 체감 ✅

핵심은 **프레임당 value 변화량을 줄이는 것**입니다. 저사양 기기에서 프레임이 적더라도, 각 프레임 사이의 위치 변화가 작아지면 빠른 왕복 대신 자연스러운 움직임이 됩니다.

---

# 7. 한계점 & 개선 방향

이 방식이 만능은 아닙니다. 몇 가지 한계가 있습니다.

## 1. 측정 오버헤드

앱 시작 시 1초간 Ticker를 돌려야 합니다. 스플래시 화면이나 로딩 중에 측정하면 사용자가 체감하지 못하지만, 측정 중에는 정확한 결과를 위해 무거운 작업을 피해야 합니다.

## 2. 하드코딩된 분기 기준

20ms, 40ms라는 기준값과 그에 대응하는 duration이 하드코딩되어 있습니다. 실제로는 애니메이션의 종류(Fade, Slide, Scale 등)마다 적절한 duration이 다를 수 있습니다. 실무에서는 BaseAnimation 같은 추상 클래스를 만들어 애니메이션 종류별로 다른 배수를 적용했습니다.

## 3. 동적 성능 변화 미반영

앱 시작 시 한 번만 측정하기 때문에, 이후 배터리 절약 모드 진입이나 백그라운드 앱 증가로 성능이 떨어지는 상황은 반영되지 않습니다. 주기적으로 재측정하는 방향으로 개선할 수 있습니다.

---

# 8. 마무리

오늘은 기기에 따라 애니메이션 속도를 다르게 구현하는 주제로 글을 작성했습니다.
저도 구현 중 어쩌다가 알게된거지만 애니메이션을 구현할 때 기기별로 다르게 동작할거라는 생각은 못해봤었네요.. 앞으로는 애니메이션을 구현할 때는 테스트하고 확인해봐야할 것 같습니다.

항상 글 읽어주시는 분들께 감사드립니다.🙌