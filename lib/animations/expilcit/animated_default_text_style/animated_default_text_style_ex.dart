import 'package:flutter/material.dart';

/// AnimatedDefaultTextStyle 사용 예제
/// 텍스트 스타일이 부드럽게 변경되는 애니메이션
class AnimatedDefaultTextStyleEx extends StatefulWidget {
  const AnimatedDefaultTextStyleEx({super.key});
  @override
  State<AnimatedDefaultTextStyleEx> createState() =>
      _AnimatedDefaultTextStyleExState();
}

class _AnimatedDefaultTextStyleExState
    extends State<AnimatedDefaultTextStyleEx> {
  bool isLarge = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AnimatedDefaultTextStyle 예제')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 기본 예제
            AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              style: TextStyle(
                fontSize: isLarge ? 60 : 20,
                color: isLarge ? Colors.red : Colors.blue,
                fontWeight: isLarge ? FontWeight.bold : FontWeight.normal,
              ),
              child: Text('텍스트 애니메이션'),
            ),

            SizedBox(height: 50),

            // 여러 텍스트 동시에 변경
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15),
              ),
              child: AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 1000),
                curve: Curves.easeOut,
                style: TextStyle(
                  fontSize: isLarge ? 24 : 16,
                  color: isLarge ? Colors.purple : Colors.black87,
                  letterSpacing: isLarge ? 2 : 0,
                  height: isLarge ? 1.5 : 1.2,
                ),
                child: Column(
                  children: [
                    Text('텍스트 애니메이션 1'),
                    Text('텍스트 애니메이션 2'),
                    Text('텍스트 애니메이션 3'),
                  ],
                ),
              ),
            ),

            SizedBox(height: 50),

            // 버튼
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isLarge = !isLarge;
                });
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text('텍스트 스타일 변경', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
