import 'package:flutter/material.dart';

/// AnimatedRotation 애니메이션 예제
class AnimatedRotationEx extends StatefulWidget {
  const AnimatedRotationEx({super.key});

  @override
  State<AnimatedRotationEx> createState() => _AnimatedRotationExState();
}

class _AnimatedRotationExState extends State<AnimatedRotationEx> {
  double _turns = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AnimatedRotation Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedRotation(
              turns: _turns,
              duration: const Duration(milliseconds: 500),
              curve: Curves.elasticOut,
              child: Container(
                width: 200,
                height: 200,
                color: Colors.red,
                child: const Center(
                  child: Text(
                    'Rotation Animation',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Rotation: ${_turns.toStringAsFixed(1)} turns'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _turns += 0.25; // 90도 회전
                    });
                  },
                  child: const Text('Rotate Right'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _turns -= 0.25; // -90도 회전
                    });
                  },
                  child: const Text('Rotate Left'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _turns = 0.0;
                });
              },
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
