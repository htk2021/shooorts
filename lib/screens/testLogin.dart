import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:flutter2/models/AppColors.dart';

class LoginTest extends StatefulWidget {
  const LoginTest({Key? key}) : super(key: key);

  @override
  _LoginTestState createState() => _LoginTestState();
}

class _LoginTestState extends State<LoginTest> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();

    _animation = Tween<Offset>(
      begin: Offset(1.0, 0.7),  // Start from the right
      end: Offset(-1.0, 0.3),  // Move to the left
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,  // Define the curve type
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: AppColors.loginBackColor,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 190),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/login_tree_reverse.png'),
                        ],
                      ),
                      Image.asset('images/title_image.png'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset('assets/images/login_tree.png'),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: constraints.maxHeight * 0.13,
                  child: GestureDetector(
                    child: Image.asset(
                      'images/kakaologinimage.png',
                      width: 200,
                      height: 50,
                    ),
                  ),
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: constraints.maxHeight * 0.5,
                    child: SlideTransition(
                      position: _animation,
                      child: Image.asset('images/birds.png'),
                    )
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
