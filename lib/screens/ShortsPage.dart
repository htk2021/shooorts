import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/models/Shorts.dart';
import 'package:flutter2/widgets/shortsPlayer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
List<Shorts> shortsList = [];
class ShortsList extends StatefulWidget {
  final List<Shorts> dataList = dummyList;
  // final int index;
  // final String shortId;
  // final String url;
  // final List<String> commentsId;
  // final String title;
  // final String profilePic;
  // final String uploader;
  // final List<String> hashtag;
  // final int likes;

  @override
  _ShortsListState createState() => _ShortsListState();
}

class _ShortsListState extends State<ShortsList> {
  late YoutubePlayerController _controller;
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
  }

  bool getLiked(String shortId) {
    bool temp = false;
    for(var i=0 ; i<widget.dataList.length ; i++) {

    }

    return temp;
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return SafeArea(
        child: (widget.dataList.isNotEmpty)
            ? Scaffold(
          body: PageView.builder(
            itemCount: widget.dataList.length,
            controller: PageController(
                initialPage: 1,
                viewportFraction: 1),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  ShortsScreen(videoId: widget.dataList[index].url,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      // mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        //upper options row
                        //skip
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
                                      CircleAvatar(
                                        backgroundImage: AssetImage('assets/images/temp_profile.png'),
                                        radius: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          '@${widget.dataList[index].uploader}',
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
                                      widget
                                          .dataList[index].title
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
                                            pushedLike = getLiked(widget.dataList[index].shortId);
                                            if (pushedLike) {
                                              // user 의 좋아요 데이터도 수정해줘야 함
                                              pushedLike = false;
                                              widget.dataList[index].likes--;
                                              likeBtnColor = Colors.white;
                                            } else {
                                              pushedLike = true;
                                              widget.dataList[index].likes--;
                                              likeBtnColor = Colors.blue;
                                              if (pushedLike) {
                                                dislikeBtnColor =
                                                    Colors.white;
                                              }
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
                                              widget.dataList[index]
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
                                        // onTap: (){
                                        //   setState(() {
                                        //     //open modal box
                                        //   });
                                        // },
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.comment_rounded,
                                              color: Colors.white,
                                              size: iconSize,
                                            ),
                                            Text(
                                              widget.dataList[index]
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
}