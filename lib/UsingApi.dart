import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  static const url = 'http://172.10.5.167:80/';
  Future<void> Useradd(String name, String userId) async {
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

  Future<void> Userdelete(String userId) async {
    const url_withfunc=url+'user/delete';
    final response = await http.post(
      Uri.parse(url_withfunc),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'userId': userId,
      }),
    );
    if (response.statusCode == 200) {
      print('새 유저 삭제 완료');
    } else {
      print('새 유저 삭제 실패');
    }
  }

  Future<void> UsersetName(String userId, String name) async {
    const url_withfunc = url + 'user/setName';
    final response = await http.post(
      Uri.parse(url_withfunc),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userId,
        'name': name,
      }),
    );
    if (response.statusCode == 200) {
      print('유저 이름 수정 완료');
    } else {
      print('유저 이름 수정 실패');
    }
  }

  Future<void> UseraddReview(String userId, String shortsId) async {
    const url_withfunc = url + 'user/addReview';
    final response = await http.post(
      Uri.parse(url_withfunc),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userId,
        'shortsId': shortsId,
      }),
    );
    if (response.statusCode == 200) {
      print('복습 영상 추가 완료');
    } else {
      print('복습 영상 추가 실패');
    }
  }

  Future<void> UserdeleteReview(String userId, String shortsId) async {
    const url_withfunc = url + 'user/deleteReview';
    final response = await http.post(
      Uri.parse(url_withfunc),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userId,
        'shortsId': shortsId,
      }),
    );
    if (response.statusCode == 200) {
      print('복습 영상 추가 완료');
    } else {
      print('복습 영상 추가 실패');
    }
  }

  Future<void> ShortsdeleteComments(String userID, String commentId) async {
    const url_withfunc = url + 'comment/deleteComments';
    final response = await http.post(
      Uri.parse(url_withfunc),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userID': userID,
        'commentId': commentId,
      }),
    );
    if (response.statusCode == 200) {
      print('댓글 삭제 완료');
    } else {
      print('댓글 삭제 실패');
    }
  }


}
