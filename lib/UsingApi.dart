import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  static const url = 'http://172.10.5.167:80/';
  Future<void> addUser(String name, String userId) async {
    const url_withfunc=url+'user/add';
    final response = await http.post(
      Uri.parse(url_withfunc),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'userId': userId,
      }),
    );
    if (response.statusCode == 200) {
      print('새 유저 추가 완료');
    } else {
      print('새 유저 추가 실패');
    }
  }





}
