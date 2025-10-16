import 'package:flutter/material.dart';

/// AnimatedContainer 사용 예제
/// 내부 속성이 변화되면 애니메이션 효과를 줄 수 있는 컨테이너
class AnimatedContainerEx extends StatefulWidget {
  const AnimatedContainerEx({super.key});
  @override
  State<AnimatedContainerEx> createState() => _AnimatedContainerExState();
}

class _AnimatedContainerExState extends State<AnimatedContainerEx> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AnimatedContainer 기본 예제')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // AnimatedContainer - 클릭하면 애니메이션!
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: AnimatedContainer(
                // 애니메이션 지속 시간
                duration: Duration(milliseconds: 500),
                // 애니메이션 곡선 (속도 변화)
                curve: Curves.easeInOut,
                // 크기 변경
                width: isExpanded ? 300 : 150,
                height: isExpanded ? 300 : 150,
                // 스타일 변경
                decoration: BoxDecoration(
                  color: isExpanded ? Colors.red : Colors.blue,
                  borderRadius: BorderRadius.circular(isExpanded ? 150 : 12),
                ),
                child: Center(
                  child: Text(
                    isExpanded ? '큰 원!' : '작은 박스',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
