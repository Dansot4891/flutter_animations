import 'package:flutter/material.dart';

import 'jump_up_animation.dart';

/// 적용 전/후 비교 페이지
///
/// - 적용 전: A기기(2000ms) vs B기기(400ms) → B가 비정상적으로 빠름
/// - 적용 후: A기기(2000ms) vs B기기(2000ms) → 둘 다 같은 속도
class AdaptiveAnimationPage extends StatelessWidget {
  const AdaptiveAnimationPage({super.key});

  static const _normalDuration = 2000;
  static const _brokenDuration = 400;
  static const _adaptiveDuration = 2000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adaptive Animation')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionTitle(
              '적용 전',
              '같은 코드인데 B기기에서는 빠르게 왔다갔다',
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: JumpUpAnimation(
                    key: const ValueKey('before-A'),
                    durationMs: _normalDuration,
                    label: 'A기기 (고사양)',
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: JumpUpAnimation(
                    key: const ValueKey('before-B'),
                    durationMs: _brokenDuration,
                    label: 'B기기 (저사양)',
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            _buildSectionTitle(
              '적용 후',
              'duration 적응으로 두 기기의 체감 속도가 비슷해짐',
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: JumpUpAnimation(
                    key: const ValueKey('after-A'),
                    durationMs: _normalDuration,
                    label: 'A기기 (고사양)',
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: JumpUpAnimation(
                    key: const ValueKey('after-B'),
                    durationMs: _adaptiveDuration,
                    label: 'B기기 (저사양)',
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, String subtitle) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
