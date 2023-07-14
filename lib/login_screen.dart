import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  Future<void> _loginWithKakao(BuildContext context) async {
    try {
      final OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
      print('카카오계정으로 로그인 성공 ${token.accessToken}');
      Navigator.pushReplacementNamed(context, '/home');
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'images/loginbackground.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: constraints.maxHeight * 0.13, // 원하는 y좌표로 설정 (예: 높이의 20%)
                  child: GestureDetector(
                    onTap: () => _loginWithKakao(context),
                    child: Image.asset(
                      'images/kakaologinimage.png',
                      width: 200,
                      height: 50,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
