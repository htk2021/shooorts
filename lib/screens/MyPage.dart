import 'package:flutter/material.dart';
import 'package:flutter2/models/AppColors.dart';
import 'package:flutter2/models/User.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
  late final User user;
  late SharedPreferences sp;
  late String userId; //이게 SharedPreferences로 저장한 카카오 회원번호

  @override
  void initState() {
    super.initState();
    loadUserId();
    // 유저 정보 불러오기
    user = User(userId: '123', name: '세 종대왕', imageurl: 'd', reviewShorts: ["123","123","123","123","123","123","123","123"], likedShorts: ["123"]);
  }

  void goToShorts(String shortsId) {

  }

  loadUserId() async {
    // SharedPreferences의 인스턴스를 필드에 저장
    sp = await SharedPreferences.getInstance();
    setState(() {
      // SharedPreferences에 counter로 저장된 값을 읽어 필드에 저장. 없을 경우 0으로 대입
      userId = (sp.getString('userId') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 80),
          CircleAvatar(
            radius: 100, // 원하는 크기로 변경
            backgroundImage: AssetImage('assets/images/temp_profile.png'),  // 원하는 이미지로 변경
          ),
          SizedBox(height: 10), // 원하는 간격으로 변경
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '이름',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // 수정버튼 클릭 시 수행할 동작
                },
              ),
            ],
          ),
          SizedBox(height: 10), // 원하는 간격으로 변경
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
            child: Container(
              margin: EdgeInsets.only(left: 15, right: 15,top: 5),
              decoration: BoxDecoration(
                color: Colors.grey[200], // 원하는 백그라운드 색상
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.0),
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 3,
                  itemCount: user.reviewShorts.length,
                  itemBuilder: (BuildContext context, int index) => GestureDetector(
                    onTap: () => goToShorts(user.reviewShorts[index]),
                    child: AspectRatio(
                      aspectRatio: 9 / 16, // 이미지의 가로:세로 비율
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0), // 이미지 코너를 둥글게 설정
                          child: AspectRatio(
                            aspectRatio: 9 / 16, // 이미지의 가로:세로 비율
                            child: Image.asset(
                              'images/temp_shorts_image.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
              ),
            )
          ),
        ],
      ),
    );
  }



}
