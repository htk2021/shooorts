import 'package:flutter2/models/Comment.dart';
import 'package:flutter2/models/Shorts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  static const url = 'http://172.10.5.167:80/';

  //User 관련 Api
  Future<void> Useradd(String name, String userId, String imageurl) async {
    const url_withfunc=url+'user/add';
    final response = await http.post(
      Uri.parse(url_withfunc),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'userId': userId,
        'imageurl': imageurl,
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

  Future<List<String>> UsergetReview(String userId) async {
    const url_withfunc = url + 'user/getReview';
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
      // 응답 처리
      final responseBody = response.body;
      final jsonData = jsonDecode(responseBody) as Map<String, dynamic>;
      final reviewList = (jsonData['reviewShorts'] as List).cast<String>();
      return reviewList;
    } else {
      print('Failed to fetch Shorts List: ${response.statusCode}');
      throw Exception('Failed to fetch Shorts List: ${response.statusCode}');
    }
  }

  Future<String?> UsergetImage(String userId) async {
    const url_withfunc = url + 'user/getImage';
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
      print('유저 사진 얻기 완료');
      return jsonDecode(response.body)['imageUrl'];
    } else {
      print('유저 사진 얻기 실패');
      return null;
    }
  }

  Future<String?> UsergetName(String userId) async {
    const url_withfunc = url + 'user/getName';
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
      print('유저 이름 얻기 완료');
      return jsonDecode(response.body)['name'];
    } else {
      print('유저 이름 얻기 실패');
      return null;
    }
  }

  Future<List<String>> Usergetthumbnails(String userId) async {
    const url_withfunc = url + 'user/getthumbnails';
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
      // 응답 처리
      final responseBody = response.body;
      final jsonData = jsonDecode(responseBody) as Map<String, dynamic>;
      final thumbnailUrls = (jsonData['thumbnailUrls'] as List<dynamic>)
          .map((item) => item as String)
          .toList();
      return thumbnailUrls;
    } else {
      print('Failed to fetch Shorts List: ${response.statusCode}');
      throw Exception('Failed to fetch Shorts List: ${response.statusCode}');
    }
  }

  Future<List<String>> getLikedList(String userId) async {
    const url_withfunc = url + 'user/getLikedList';
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
      final jsonList = jsonDecode(responseBody) as List<dynamic>;
      final stringList = jsonList.map((item) => item.toString()).toList();
      return stringList;
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

  Future<List<String>> getMoreList(String shortsId) async {
    const url_withfunc = url + 'shorts/getReview';
    final response = await http.post(
      Uri.parse(url_withfunc),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'shortsId': shortsId,
      }),
    );
    if (response.statusCode == 200) {
      final responseBody = response.body;
      final jsonData = jsonDecode(responseBody) as Map<String, dynamic>;
      final shortsList = List<String>.from(jsonData['shortsList'] as List<dynamic>);
      return shortsList;
    } else {
      print('Failed to fetch Shorts List: ${response.statusCode}');
      return [];
    }
  }

  Future<void> addShorts() async {
    const url_withfunc = url + 'shorts/addShorts';
    final response = await http.post(
      Uri.parse(url_withfunc),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
      }),
    );
    if (response.statusCode == 200) {
      print('유튜브로부터 영상 추가 완료');
    } else {
      print('유튜브로부터 영상 추가 실패 : ${response.statusCode}');
    }
  }


  Future<String?> getShortsUrl(String shortsId) async {
    const url_withfunc = url + 'shorts/getshortsurl';
    final response = await http.post(
      Uri.parse(url_withfunc),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'shortsId': shortsId,
      }),
    );
    if (response.statusCode == 200) {
      print('url 얻기 완료');
      return jsonDecode(response.body)['shortsUrl'];
    } else {
      print('url 얻기 실패');
      return null;
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

  Future<void> addComments(String userID, String shortsId, String comment) async {
    const url_withfunc = url + 'comment/addComments';
    final response = await http.post(
      Uri.parse(url_withfunc),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userID,
        'shortsId': shortsId,
        'comment': comment,
      }),
    );
    if (response.statusCode == 200) {
      print('댓글 추가 완료');
    } else {
      print('댓글 추가 실패');
    }
  }

  Future<void> deleteComments(String userID, String commentId) async {
    const url_withfunc = url + 'comment/deleteComments';
    final response = await http.post(
      Uri.parse(url_withfunc),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userID,
        'commentId': commentId,
      }),
    );
    if (response.statusCode == 200) {
      print('댓글 삭제 완료');
    } else {
      print('댓글 삭제 실패');
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

  Future<Shorts> updateHashtags(String shortsId, List<String> hashtags) async {
    const url_withfunc=url+'shorts/updateHashtags';
    final response = await http.put(
      Uri.parse(url_withfunc),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'shortsId': shortsId,
        'hashtag': hashtags
      }),
    );
    if (response.statusCode == 200) {
      print('hashtag Update successfully');
      return Shorts.fromJson(jsonDecode(response.body));
    } else {
      print('hashtag update fail : ${response.statusCode}');
      throw Exception('Failed to update hashtags.');
    }
  }

}
