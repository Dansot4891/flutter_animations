import 'package:flutter/material.dart';

/// AnimatedOpacity 사용 예제
/// 투명도가 변경되면 애니메이션 효과를 줄 수 있는 위젯
/// 투명도만 변경되기 때문에 위젯이 없어지는 것이 아니라 위치는 변경되지 않는다.
class AnimatedOpacityEx extends StatefulWidget {
  const AnimatedOpacityEx({super.key});
  @override
  State<AnimatedOpacityEx> createState() => _AnimatedOpacityExState();
}

class _AnimatedOpacityExState extends State<AnimatedOpacityEx> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AnimatedOpacity 예제')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 기본 예제 - 페이드 인/아웃
            AnimatedOpacity(
              opacity: isVisible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    '페이드 효과',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            SizedBox(height: 50),

            // 버튼
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(
                isVisible ? '숨기기' : '보이기',
                style: TextStyle(fontSize: 18),
              ),
            ),

            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
