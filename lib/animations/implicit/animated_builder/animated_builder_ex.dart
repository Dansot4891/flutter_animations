import 'package:flutter/material.dart';

// ⚠️ 중요: SingleTickerProviderStateMixin 필수!
// SingleTickerProviderStateMixin이 왜 필수일까?
// 애니메이션은 화면을 매 프레임(60fps)마다 갱신해야 함
// TickerProvider는 "화면이 보일 때만" 애니메이션을 돌려줌
// → 성능 최적화! (백그라운드에서는 멈춤)
class AnimatedBuilderEx extends StatefulWidget {
  const AnimatedBuilderEx({super.key});
  @override
  State<AnimatedBuilderEx> createState() => _AnimatedBuilderExState();
}

class _AnimatedBuilderExState extends State<AnimatedBuilderEx>
    with SingleTickerProviderStateMixin {
  // 1. AnimationController 선언
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // 2. Controller 초기화
    _controller = AnimationController(
      duration: Duration(seconds: 1), // 애니메이션 길이
      vsync: this, // (SingleTickerProviderStateMixin 때문)
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AnimationController 기본')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 프로그레스 바로 시각화
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Column(
                  children: [
                    // Controller의 현재 값 표시
                    Text(
                      '현재 값: ${_controller.value.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      child: LinearProgressIndicator(
                        value: _controller.value, // 0.0 ~ 1.0
                        minHeight: 20,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation(Colors.blue),
                      ),
                    ),
                    SizedBox(height: 20),

                    Text(
                      '${(_controller.value * 100).toStringAsFixed(0)}%',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                );
              },
            ),

            SizedBox(height: 50),

            // 상태 표시
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: _controller.isAnimating
                    ? Colors.green[100]
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _controller.isAnimating ? '▶️ 재생 중' : '⏸️ 정지',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _controller.isAnimating
                      ? Colors.green[900]
                      : Colors.grey[700],
                ),
              ),
            ),

            SizedBox(height: 50),

            // 컨트롤 버튼들
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                // Forward 버튼
                ElevatedButton.icon(
                  onPressed: () {
                    _controller.forward(); // 0.0 → 1.0
                  },
                  icon: Icon(Icons.play_arrow),
                  label: Text('Forward'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),

                // Reverse 버튼
                ElevatedButton.icon(
                  onPressed: () {
                    _controller.reverse(); // 1.0 → 0.0
                  },
                  icon: Icon(Icons.replay),
                  label: Text('Reverse'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                ),

                // Stop 버튼
                ElevatedButton.icon(
                  onPressed: () {
                    _controller.stop(); // 멈춤
                  },
                  icon: Icon(Icons.stop),
                  label: Text('Stop'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),

                // Reset 버튼
                ElevatedButton.icon(
                  onPressed: () {
                    _controller.reset(); // 0.0으로 돌아감
                  },
                  icon: Icon(Icons.refresh),
                  label: Text('Reset'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                ),

                // Repeat 버튼
                ElevatedButton.icon(
                  onPressed: () {
                    _controller.repeat(); // 무한 반복
                  },
                  icon: Icon(Icons.repeat),
                  label: Text('Repeat'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                  ),
                ),

                // Repeat Reverse 버튼
                ElevatedButton.icon(
                  onPressed: () {
                    _controller.repeat(reverse: true); // 앞뒤로 반복
                  },
                  icon: Icon(Icons.repeat_one),
                  label: Text('Repeat↔'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
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
