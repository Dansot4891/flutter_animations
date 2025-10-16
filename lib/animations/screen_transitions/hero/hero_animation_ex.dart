import 'package:flutter/material.dart';
import 'package:flutter_animations/animations/screen_transitions/hero/hero_animation_detail_ex.dart';

/// Hero Animation 예제 - 첫 번째 화면
class HeroAnimationEx extends StatelessWidget {
  const HeroAnimationEx({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero Animation')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '카드를 탭해서 Hero 애니메이션을 확인해보세요!',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HeroAnimationDetailEx(),
                  ),
                );
              },
              child: Hero(
                tag: 'hero-card',
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
