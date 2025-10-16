import 'package:flutter/material.dart';
import 'package:flutter_animations/animations/screen_transitions/transitions/custom_page_transition_detail_ex.dart';

/// 커스텀 화면 전환 애니메이션 예제
class CustomPageTransitionEx extends StatelessWidget {
  const CustomPageTransitionEx({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Page Transitions')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '다양한 화면 전환 애니메이션을\n확인해보세요!',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            _buildTransitionButton(
              context,
              '슬라이드 전환',
              () => _navigateWithSlideTransition(context),
            ),
            _buildTransitionButton(
              context,
              '페이드 전환',
              () => _navigateWithFadeTransition(context),
            ),
            _buildTransitionButton(
              context,
              '스케일 전환',
              () => _navigateWithScaleTransition(context),
            ),
            _buildTransitionButton(
              context,
              '회전 전환',
              () => _navigateWithRotationTransition(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransitionButton(
    BuildContext context,
    String title,
    VoidCallback onPressed,
  ) {
    return Container(
      width: 200,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(onPressed: onPressed, child: Text(title)),
    );
  }

  void _navigateWithSlideTransition(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const CustomPageTransitionDetailEx(
              title: '슬라이드 전환',
              color: Colors.green,
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  void _navigateWithFadeTransition(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const CustomPageTransitionDetailEx(
              title: '페이드 전환',
              color: Colors.orange,
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  void _navigateWithScaleTransition(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const CustomPageTransitionDetailEx(
              title: '스케일 전환',
              color: Colors.purple,
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(scale: animation, child: child);
        },
      ),
    );
  }

  void _navigateWithRotationTransition(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const CustomPageTransitionDetailEx(
              title: '회전 전환',
              color: Colors.red,
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return RotationTransition(turns: animation, child: child);
        },
      ),
    );
  }
}
