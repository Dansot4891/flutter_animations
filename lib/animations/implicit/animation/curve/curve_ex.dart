import 'package:flutter/material.dart';

class CurveEx extends StatefulWidget {
  const CurveEx({super.key});
  @override
  State<CurveEx> createState() => _CurveExState();
}

class _CurveExState extends State<CurveEx> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _curveAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // ✅ 수정: Tween + CurvedAnimation
    _curveAnimation = Tween<double>(
      begin: 50, // 시작 크기
      end: 300, // 끝 크기
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Curve 예제')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _curveAnimation,
            builder: (context, child) {
              return Container(
                width: _curveAnimation.value, // 50~300
                height: _curveAnimation.value, // 50~300
                color: Colors.blue,
                child: Center(
                  child: Text(
                    _curveAnimation.value.toStringAsFixed(0),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              _controller.forward();
            },
            child: Text('start'),
          ),
          ElevatedButton(
            onPressed: () {
              _controller.reverse();
            },
            child: Text('reverse'),
          ),
        ],
      ),
    );
  }
}
