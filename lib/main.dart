import 'package:flutter/material.dart';
import 'package:flutter2/screens/TabPage.dart';
import 'package:flutter2/screens/testLogin.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'login_screen.dart';
import 'my_home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(
    nativeAppKey: '947a3f7c9f2d578aeae0e0670a45fa95',
    javaScriptAppKey: 'b69457d37625a174dd26dd9e971e6d35',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) =>  TabPage(),
        '/home': (context) => TabPage(),
      },
    );
  }
}
