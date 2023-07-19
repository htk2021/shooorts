import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter2/UsingApi.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:flutter2/models/AppColors.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _animation;
  late final Animation<Offset> _animation_tiger;
  late final SharedPreferences sp;
  final apiClient = ApiClient();

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

    _animation_tiger = TweenSequence<Offset>(
      [
        TweenSequenceItem<Offset>(
          tween: Tween<Offset>(
            begin: Offset(0.0, 0.7),
            end: Offset(0.0, 0.0),
          ),
          weight: 50.0,
        ),
        TweenSequenceItem<Offset>(
          tween: Tween<Offset>(
            begin: Offset(0.0, 0.0),
            end: Offset(0.0, 0.7),
          ),
          weight: 50.0,
        ),
      ],
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );


    _checkTokenValid();
  }


  Future<void> _checkTokenValid() async {
    if (await AuthApi.instance.hasToken()) {
      try {
        AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
        print('토큰 유효성 체크 성공 ${tokenInfo.id} ${tokenInfo.expiresIn}');
        Navigator.pushReplacementNamed(context, '/home');
      } catch (error) {
        if (error is KakaoException && error.isInvalidTokenError()) {
          print('토큰 만료 $error');
        } else {
          print('토큰 정보 조회 실패 $error');
        }
      }
    } else {
      print('발급된 토큰 없음');
    }
  }



  Future<void> _loginWithKakao(BuildContext context) async {

    if (await AuthApi.instance.hasToken()) {
      try {
        AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
        print('토큰 유효성 체크 성공 ${tokenInfo.id} ${tokenInfo.expiresIn}');
        Navigator.pushReplacementNamed(context, '/home');
      } catch (error) {
        if (error is KakaoException && error.isInvalidTokenError()) {
          print('토큰 만료 $error');
        } else {
          print('토큰 정보 조회 실패 $error');
        }
      }
    } else {
      print('발급된 토큰 없음');
      try {
        // 카카오계정으로 로그인
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        print('로그인 성공 ${token.accessToken}');

        // 새 유저 추가
        try {
          User user = await UserApi.instance.me();
          await apiClient.Useradd(user.kakaoAccount?.profile?.nickname ?? '', user.id.toString(), user.kakaoAccount?.profile?.thumbnailImageUrl ?? '');
          sp = await SharedPreferences.getInstance();
          await sp.setString('userId', user.id.toString());
        } catch (error) {
          print('사용자 정보 요청 실패 $error');
        }

        Navigator.pushReplacementNamed(context, '/home');
      } catch (error) {
        print('로그인 실패 $error');
      }
    }

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
                  bottom: constraints.maxHeight * 0.5,
                  child: SlideTransition(
                    position: _animation,
                    child: Image.asset('images/birds.png'),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SlideTransition(
                    position: _animation_tiger,
                    child: Image.asset('images/three_tigers.png'),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: constraints.maxHeight * 0.13,
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
