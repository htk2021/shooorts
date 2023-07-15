class User {
  String userId;
  String kakaoKey;
  String name;
  List<String> reviewShorts;
  List<String> likedShorts;

  User({required this.userId, required this.kakaoKey, required this.name, required this.reviewShorts,required this.likedShorts});
}