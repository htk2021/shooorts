import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/models/Shorts.dart';
import 'package:flutter2/widgets/shortsPlayer.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter2/models/AppColors.dart';
import 'package:flutter2/UsingApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Comment.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
List<Shorts> shortsList = [];
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

  List<Shorts> dataList = [];
  List<Comment> commentList = [];
  List<String> likedList = [];

  bool pushedLike = false;
  Color likeBtnColor = Colors.white,
      dislikeBtnColor = Colors.white,
      subscribeBtnColor = Colors.red;
  double iconSize = 33;
  TextStyle textStyle1 = const TextStyle(
    color: Colors.white,
    fontSize: 15,
  );

  @override
  void initState() {
    super.initState();
    getShorts();
    loadUserId();
    getComments(dataList[0].shortId);
  }

  loadUserId() async {
    // SharedPreferences의 인스턴스를 필드에 저장
    sp = await SharedPreferences.getInstance();
    setState(() {
      // SharedPreferences에 counter로 저장된 값을 읽어 필드에 저장. 없을 경우 0으로 대입
      userId = (sp.getString('userId') ?? '');
    });
  }

  void getLikedList() async {
    likedList = await apiClient.getLikedList(userId);
  }

  bool getLiked(String shortsId) {
    for(var i=0 ; i<likedList.length ; i++) {
      if(likedList[i] == shortsId) {
        return true;
      }
    }
    return false;
  }

  void getComments(String shortsId) async {
    commentList = await apiClient.getCommentsList(shortsId);
  }

  void getShorts() async {
    dataList = await apiClient.getShortsList();
  }

  void liked(String shortsId) async {

  }

  void unliked(String shortsId) async {

  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return SafeArea(
        child: (dataList.isNotEmpty)
            ? Scaffold(
          body: PageView.builder(
            itemCount: dataList.length,
            onPageChanged: (index) {
              getComments(dataList[index].shortId);
            },
            controller: PageController(
                initialPage: 1,
                viewportFraction: 1),
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
                              Column(
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
                                    ),
                                  )
                                ],
                              ),
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
                                              unliked(dataList[index].shortId);
                                              likeBtnColor = Colors.white;
                                            } else {
                                              liked(dataList[index].shortId);
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
                                        // onTap: (){
                                        //   setState(() {
                                        //     //open share modal box
                                        //   });
                                        // },
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.bookmark_border_rounded,
                                              color: Colors.white,
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
        ) : Container()
    );

  }

  void openComments(int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.8,  // covers 80% of screen
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.commentBackColor,  // 색상 설정
                  borderRadius: BorderRadius.circular(10),  // 모서리 둥글게
                ),
                // height: MediaQuery.of(context).size.height * 0.8 * 0.3, // 상단의 30%
                child: Wrap(
                  spacing: 8.0, // gap between adjacent buttons
                  runSpacing: 4.0, // gap between lines
                  children: <Widget>[
                    for (var item in dataList[index].hashtag)
                      TextButton( // or ElevatedButton
                        onPressed: () {},  // add functionality as per requirements
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
                  itemCount: commentList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            // backgroundImage: AssetImage('assets/images/temp_profile.png'),
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/placeholder_image.png', // 기본 이미지 경로
                              image: "asd", // 실제 이미지 경로
                              fit: BoxFit.cover, // 이미지 채우기 모드
                              width: 200, // 이미지 너비
                              height: 200, // 이미지 높이
                            ),
                            radius: 20,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  commentList[index].userId,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(commentList[index].comment),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }



}