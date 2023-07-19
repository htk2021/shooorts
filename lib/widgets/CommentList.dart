import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/UsingApi.dart';
import 'package:flutter2/models/AppColors.dart';
import 'package:flutter2/models/Comment.dart';
import 'package:flutter2/models/Shorts.dart';
import 'package:url_launcher/url_launcher.dart';

class CommentList extends StatefulWidget {
  final String shortsId;
  final List<String> hashtags;
  final String userId;

  CommentList({required this.shortsId, required this.hashtags, required this.userId});

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  late Future<List<Comment>> _commentsFuture;
  late List<String> realHashTag;
  final _commentController = TextEditingController();
  ApiClient apiClient = ApiClient();
  String currentComment = "";
  final hashtagRegExp = RegExp(r"\B#\w\w+");

  Future<List<Comment>> _getComments(String shortsId) async {
    print("load comment ${shortsId}");
    return await apiClient.getCommentsList(shortsId);
  }

  void addComment(String shortsId, String comment) async {
    await apiClient.addComments(widget.userId, shortsId, comment);
    print('userid : ${widget.userId}, shortdId : ${shortsId}, comment : ${comment}');

    // 서버에서 데이터를 새로 불러오는 비동기 함수 호출
    // final newData = await apiClient.getCommentsList(shortsId);

    setState(() {
      // 받아온 새로운 데이터로 상태 변수를 업데이트
      _commentsFuture = _getComments(shortsId);
    });
  }

  _launchURL(String hashtag) async {
    String url = 'https://namu.wiki/w/$hashtag';
    Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception("could not launch $_url");
    }
  }

  void handleHashtags(List<String> hashtags) async {
    for(int i=0 ; i<hashtags.length ; i++) {
      hashtags[i] = hashtags[i].substring(1);
    }
    Shorts temp;
    temp = await apiClient.updateHashtags(widget.shortsId, hashtags);
    setState(() {
      realHashTag = temp.hashtag;
    });
  }

  @override
  void initState() {
    super.initState();
    _commentsFuture = _getComments(widget.shortsId);
    realHashTag = widget.hashtags;
  }

  void refreshComments() {
    setState(() {
      _commentsFuture = _getComments(widget.shortsId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Comment>>(
      future: _commentsFuture,
      builder: (context, snapshot) {
        return FutureBuilder<List<Comment>>(
          future: _commentsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // 데이터 로딩 중일 때 보여줄 UI
              print("asd");
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // 에러 발생 시 보여줄 UI
              return Text('Error2: ${snapshot.error}');
            } else {
              List<Comment>? commentList = snapshot.data;
              // 데이터 로딩이 완료되면 보여줄 UI
              return Container(
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.8, // covers 80% of screen
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: AppColors.commentBackColor, // 색상 설정
                        borderRadius: BorderRadius.circular(10), // 모서리 둥글게
                      ),
                      // height: MediaQuery.of(context).size.height * 0.8 * 0.3, // 상단의 30%
                      child: Wrap(
                        spacing: 8.0, // gap between adjacent buttons
                        runSpacing: 4.0, // gap between lines
                        children: <Widget>[
                          for (var item in realHashTag)
                            TextButton(
                              onPressed: () {
                                _launchURL(item);
                              },
                              child: Text(item),
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: commentList?.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  // backgroundImage: AssetImage('assets/images/temp_profile.png'),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/placeholder_image.png',
                                    image: commentList![index].profileUrl,
                                    fit: BoxFit.cover,
                                    width: 200,
                                    height: 200,
                                  ),
                                  radius: 20,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        commentList![index].userId,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(commentList![index].comment),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),//EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top:20, bottom: 10),
                                // padding: EdgeInsets.only(),
                                child: TextField(
                                  controller: _commentController,
                                  onChanged: (value) {
                                    setState(() {
                                      currentComment = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      hintText: "댓글을 입력하세요",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(vertical: 10)
                                  ),
                                ),
                              )
                          ),
                          SizedBox(width: 10,),
                          ElevatedButton(
                              onPressed: () {
                                if(currentComment.isNotEmpty) {
                                  //todo
                                  addComment(widget.shortsId, currentComment);
                                  var matches = hashtagRegExp.allMatches(currentComment);
                                  if(matches.isNotEmpty) {
                                    var hashtags = matches.map((match) => currentComment.substring(match.start, match.end)).toList();
                                    handleHashtags(hashtags);
                                  }
                                  currentComment = "";
                                  _commentController.clear();
                                }
                              },
                              child: Text('전송'))
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          },
        );
      },
    );
  }
}
