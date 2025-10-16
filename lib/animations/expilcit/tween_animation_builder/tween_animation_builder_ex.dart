import 'package:flutter/material.dart';

/// TweenAnimationBuilder 사용 예제
/// 숫자 카운터 애니메이션
/// 프로그레스 바 애니메이션
/// 원형 프로그레스 애니메이션
class TweenAnimationBuilderEx extends StatefulWidget {
  const TweenAnimationBuilderEx({super.key});
  @override
  State<TweenAnimationBuilderEx> createState() =>
      _TweenAnimationBuilderExState();
}

class _TweenAnimationBuilderExState extends State<TweenAnimationBuilderEx> {
  double targetValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TweenAnimationBuilder 기본')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 기본 예제 - 숫자 카운터 애니메이션
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: targetValue),
              duration: Duration(seconds: 1),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Text(
                  value.toStringAsFixed(0),
                  style: TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                );
              },
            ),

            SizedBox(height: 50),

            // 프로그레스 바 애니메이션
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  Text(
                    '프로그레스 바',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: targetValue / 100),
                    duration: Duration(seconds: 1),
                    curve: Curves.easeInOut,
                    builder: (context, value, child) {
                      return Column(
                        children: [
                          LinearProgressIndicator(
                            value: value,
                            minHeight: 20,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.blue,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '${(value * 100).toStringAsFixed(0)}%',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 50),

            // 원형 프로그레스
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: targetValue / 100),
              duration: Duration(milliseconds: 1500),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: CircularProgressIndicator(
                        value: value,
                        strokeWidth: 15,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                    ),
                    Text(
                      '${(value * 100).toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),

            SizedBox(height: 50),

            Wrap(
              spacing: 10,
              children: [25, 50, 75, 100]
                  .map(
                    (e) => ElevatedButton(
                      onPressed: () {
                        setState(() {
                          targetValue = e.toDouble();
                        });
                      },
                      child: Text(e.toString()),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
