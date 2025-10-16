import 'package:flutter/material.dart';

/// AnimatedPositioned 사용 예제
/// Stack 안에서만 사용 가능
/// top, left, right, bottom 위치 애니메이션
/// 위젯이 부드럽게 이동
/// 크기도 함께 변경 가능 (width, height)
class AnimatedPositionedEx extends StatefulWidget {
  const AnimatedPositionedEx({super.key});
  @override
  State<AnimatedPositionedEx> createState() => _AnimatedPositionedExState();
}

class _AnimatedPositionedExState extends State<AnimatedPositionedEx> {
  bool isMoved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AnimatedPositioned 예제')),
      body: Column(
        children: [
          // 기본 예제 - 왼쪽 위에서 오른쪽 아래로 이동
          Expanded(
            child: Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[400]!, width: 2),
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    // 위치 변경
                    top: isMoved ? 200 : 50,
                    left: isMoved ? 200 : 50,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          '이동!',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 버튼
          Padding(
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  isMoved = !isMoved;
                });
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text('위치 이동', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
