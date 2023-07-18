import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/models/Shorts.dart';
import 'package:flutter2/widgets/CommentList.dart';
import 'package:flutter2/widgets/shortsPlayer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter2/models/AppColors.dart';
import 'package:flutter2/UsingApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Comment.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
class ShortsList extends StatefulWidget {
  // final List<Shorts> dataList = dummyList;

  @override
  _ShortsListState createState() => _ShortsListState();
}

class _ShortsListState extends State<ShortsList> {
  late YoutubePlayerController _controller;
  late SharedPreferences sp;
  late String userId;
  final apiClient = ApiClient();
  String currentComment = "";
  late Future<List<Comment>> _commentsFuture;
  final _commentController = TextEditingController();

  List<Shorts> dataList = [];
  // List<Comment> commentList = [];
  List<String> likedList = [];
  List<String> reviewList = [];

  bool pushedLike = false;
  bool pushedReview = false;
  Color likeBtnColor = Colors.white,
      reviewBtnColor = Colors.white;
  double iconSize = 33;
  TextStyle textStyle1 = const TextStyle(
    color: Colors.white,
    fontSize: 15,
  );

  @override
  void initState() {
    super.initState();
    loadData();
  }
  void loadData() async {
    // await getShorts();
    await loadUserId();
  }



  loadUserId() async {
    // SharedPreferences의 인스턴스를 필드에 저장
    sp = await SharedPreferences.getInstance();
    setState(() {
      // SharedPreferences에 counter로 저장된 값을 읽어 필드에 저장. 없을 경우 0으로 대입
      userId = (sp.getString('userId') ?? '');
      getLikedList();
      getReviewList();
    });
  }

  void getLikedList() async {
    likedList = await apiClient.getLikedList(userId);
  }

  void getReviewList() async {
    reviewList = await apiClient.getReview(userId);
  }

  bool getLiked(String shortsId) {
    for(var i=0 ; i<likedList.length ; i++) {
      if(likedList[i] == shortsId) {
        return true;
      }
    }
    return false;
  }

  bool getReview(String shortsId) {
    for(var i=0 ; i<reviewList.length ; i++) {
      if(reviewList[i] == shortsId) {
        return true;
      }
    }
    return false;
  }

  void liked(String shortsId,int index) async {
    await apiClient.shortsLikeUp(userId, shortsId);
    dataList[index].likes++;
    likedList.add(shortsId);
  }

  void unliked(String shortsId, int index) async {
    await apiClient.shortsLikeDown(userId, shortsId);
    dataList[index].likes--;
    for(var i=0 ; i<likedList.length ; i++) {
      if(likedList[i] == shortsId) {
        likedList.removeAt(i);
        break;
      }
    }
  }

  Future _getShorts() async {
    dataList = await apiClient.getShortsList();
  }

  Future<List<Comment>> _getComments(String shortsId) async {
    print("load comment ${shortsId}");
    return await apiClient.getCommentsList(shortsId);
  }





  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: FutureBuilder(
        future: _getShorts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 데이터 로딩 중일 때 보여줄 UI
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // 에러 발생 시 보여줄 UI
            return Text('Error: ${snapshot.error}');
          } else {
            // 데이터 로딩이 완료되면 보여줄 UI
            return (dataList.isNotEmpty)
                ? Scaffold(
              body: PageView.builder(
                itemCount: dataList.length,
                controller: PageController(
                  initialPage: 1,
                  viewportFraction: 1,
                ),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      // 쇼츠 화면
                      ShortsScreen(videoId: dataList[index].url,),
                      // 버튼 & 이외 내용들
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 15),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          // 업로더 프로필
                                          CircleAvatar(
                                            backgroundImage: AssetImage('assets/images/temp_profile.png'),
                                            radius: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              // 업로더 이름
                                              '@${dataList[index].uploader}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          // 쇼츠 제목
                                          dataList[index].title
                                              .toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.visible,
                                          maxLines: null,
                                        ),
                                      )
                                    ],
                                  ),),

                                  SizedBox(
                                    child: Column(
                                      children: [
                                        //like btn
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 25),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                pushedLike = getLiked(dataList[index].shortId);
                                                if (pushedLike) {
                                                  // user 의 좋아요 데이터도 수정해줘야 함
                                                  unliked(dataList[index].shortId, index);
                                                  likeBtnColor = Colors.white;
                                                } else {
                                                  liked(dataList[index].shortId, index);
                                                  likeBtnColor = Colors.blue;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Icons.thumb_up_rounded,
                                                  color: likeBtnColor,
                                                  size: iconSize,
                                                ),
                                                Text(
                                                  dataList[index]
                                                      .likes
                                                      .toString(),
                                                  style: textStyle1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        //comment btn
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(bottom: 25),
                                          child: InkWell(
                                            onTap: (){
                                              setState(() {
                                                //open modal box
                                                openComments(index);
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Icons.comment_rounded,
                                                  color: Colors.white,
                                                  size: iconSize,
                                                ),
                                                Text(
                                                  dataList[index]
                                                      .commentsId.length
                                                      .toString(),
                                                  style: textStyle1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        //save btn
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(bottom: 25),
                                          child: InkWell(
                                            onTap: (){
                                              setState(() {
                                                pushedReview = getReview(dataList[index].shortId);
                                                if (pushedReview) {
                                                  // 복습에 저장하기
                                                  reviewBtnColor = Colors.white;
                                                } else {
                                                  // 복습에서 빼기
                                                  reviewBtnColor = Colors.blue;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Icons.bookmark_border_rounded,
                                                  color: reviewBtnColor,
                                                  size: iconSize,
                                                ),
                                                Text(
                                                  'Save',
                                                  style: textStyle1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                    ],
                  );
                },
              ),
            )
                : Container();
          }
        },
      ),
    );
  }

  void openComments(int index) {
    _commentsFuture = _getComments(dataList[index].shortId);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return CommentList(shortsId: dataList[index].shortId, hashtags: dataList[index].hashtag, userId: userId);
      },
    );
  }




}