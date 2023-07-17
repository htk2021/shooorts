class User {
  String userId;
  String name;
  String imageurl;
  List<String> reviewShorts;
  List<String> likedShorts;

  User({required this.userId, required this.name, required this.imageurl, required this.reviewShorts, required this.likedShorts});
}