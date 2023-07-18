import 'package:flutter/material.dart';
import 'package:flutter2/UsingApi.dart';
import 'package:flutter2/models/AppColors.dart';
import 'package:flutter2/models/User.dart';
import 'package:flutter2/screens/ShortsPage.dart';
import 'package:flutter2/widgets/shortsPlayer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
  late SharedPreferences sp;
  late String userId; // 이게 SharedPreferences로 저장한 카카오 회원번호
  final apiClient = ApiClient();
  bool showShorts = false;
  String selectedShortsId = "";

  @override
  void initState() {
    super.initState();
    loadUserId();
  }

  void goToShorts(String shortsId) {
    setState(() {
      showShorts = true;
      selectedShortsId = shortsId;
    });
  }

  void loadUserId() async {
    // SharedPreferences의 인스턴스를 필드에 저장
    sp = await SharedPreferences.getInstance();
    setState(() {
      // SharedPreferences에 저장된 값을 읽어 필드에 저장. 없을 경우 빈 문자열로 대입
      userId = sp.getString('userId') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildMyPage(),
          if (showShorts) buildShortsOverlay(),
        ],
      ),
    );
  }

  Widget buildMyPage() {
    return FutureBuilder<User>(
      future: _loadUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final user = snapshot.data!;
          return Column(
            children: [
              SizedBox(height: 80),
              CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage(user.imageurl),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // 수정버튼 클릭 시 수행할 동작
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text("복습할 밈"),
                  )
                ],
              ),
              Expanded(
                child: FutureBuilder<List<String>>(
                  future: _loadThumbnails(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final thumbnailUrls = snapshot.data!;
                      return Container(
                        margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1.0),
                          child: StaggeredGridView.countBuilder(
                            crossAxisCount: 3,
                            itemCount: thumbnailUrls.length,
                            itemBuilder: (BuildContext context, int index) {
                              final imageUrl = thumbnailUrls[index];
                              return GestureDetector(
                                onTap: () => goToShorts(user.reviewShorts[index]),
                                child: AspectRatio(
                                  aspectRatio: 9 / 16,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Image.network(
                                        imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget buildShortsOverlay() {
    return Positioned.fill(
      child: ShortsScreen(
        videoId: selectedShortsId,
        onClose: () {
          setState(() {
            showShorts = false;
            selectedShortsId = "";
          });
        },
      ),
    );
  }

  Future<User> _loadUser() async {
    final imageUrl = await apiClient.UsergetImage("2910713202");
    final name = await apiClient.UsergetName("2910713202");
    final reviewshorts = await apiClient.UsergetReview("2910713202");
    return User(
      userId: userId,
      name: name ?? '넙죽이',
      imageurl: imageUrl ?? 'assets/images/temp_profile.png',
      reviewShorts: reviewshorts,
      likedShorts: ["123"],
    );
  }

  Future<List<String>> _loadThumbnails() async {
    return await apiClient.Usergetthumbnails("2910713202");
  }
}
