import 'package:flutter/material.dart';

class AnimatedContainerEx extends StatefulWidget {
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
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: isExpanded ? 20 : 10,
                      offset: Offset(0, isExpanded ? 10 : 5),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    isExpanded ? '큰 원!' : '작은 박스',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isExpanded ? 24 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 40),

            // 설명 박스
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.amber[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '💡 AnimatedContainer 핵심',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber[900],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '• duration: 애니메이션 지속 시간\n'
                    '• curve: 애니메이션 속도 곡선\n'
                    '• setState()로 값만 바꾸면 자동 애니메이션!\n'
                    '• 위 박스를 탭해보세요!',
                    style: TextStyle(fontSize: 14, color: Colors.amber[900]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
