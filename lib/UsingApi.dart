import 'package:flutter2/models/Comment.dart';
import 'package:flutter2/models/Shorts.dart';
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

  // api 추가해야함
  Future<List<String>> getLikedList(String userId) async {
    const url_withfunc = url + 'comment/getLikedList';
    final response = await http.post(
      Uri.parse(url_withfunc),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userId,
      }),
    );
    if (response.statusCode == 200) {
      // 응답 처리
      final responseBody = response.body;
      final jsonList = jsonDecode(responseBody) as List<String>;
      return jsonList;
    } else {
      print('Failed to fetch Shorts List: ${response.statusCode}');
      throw Exception('Failed to fetch Shorts List: ${response.statusCode}');
    }
  }

  // Shorts 관련 API

  Future<void> shortsLikeUp(String userId, String shortsId) async {
    const url_withfunc=url+'shorts/likeUp';
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
      print('좋아요 완료');
    } else {
      print('좋아요 실패 : ${response.statusCode}');
    }
  }

  Future<void> shortsLikeDown(String userId, String shortsId) async {
    const url_withfunc=url+'shorts/likeDown';
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
      print('좋아요 취소 완료');
    } else {
      print('좋아요 취소 실패 : ${response.statusCode}');
    }
  }

  Future<List<Shorts>> getShortsList() async {
    const url_withfunc = url + 'shorts/getList';
    final response = await http.get(
      Uri.parse(url_withfunc),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      // 응답 처리
      final responseBody = response.body;
      final jsonList = jsonDecode(responseBody) as List<dynamic>;
      final shortsList = jsonList.map((item) => Shorts.fromJson(item)).toList();
      return shortsList;
    } else {
      print('Failed to fetch Shorts List: ${response.statusCode}');
      throw Exception('Failed to fetch Shorts List: ${response.statusCode}');
    }
  }

  // Comment 관련 API

  Future<List<Comment>> getCommentsList(String shortsId) async {
    const url_withfunc = url + 'comment/getComments';
    final response = await http.post(
      Uri.parse(url_withfunc),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'shortsId': shortsId,
      }),
    );
    if (response.statusCode == 200) {
      // 응답 처리
      final responseBody = response.body;
      final jsonList = jsonDecode(responseBody) as List<dynamic>;
      final commentsList = jsonList.map((item) => Comment.fromJson(item)).toList();
      return commentsList;
    } else {
      print('Failed to fetch Shorts List: ${response.statusCode}');
      throw Exception('Failed to fetch Shorts List: ${response.statusCode}');
    }
  }


  Future<void> commentModify(String userId, String commentId, String comment) async {
    const url_withfunc=url+'comment/modifyComments';
    final response = await http.post(
      Uri.parse(url_withfunc),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userId,
        'commentId': commentId,
        'comment' : comment,
      }),
    );
    if (response.statusCode == 200) {
      print('좋아요 취소 완료');
    } else {
      print('좋아요 취소 실패 : ${response.statusCode}');
    }
  }

}
