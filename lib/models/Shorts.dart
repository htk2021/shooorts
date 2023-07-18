class Shorts {
  String shortId;
  String url;

  List<String> commentsId;
  String title;
  String profilePic;
  String uploader;
  List<String> hashtag;

  int likes;
  String thumbnails;

  Shorts({required this.shortId, required this.url, required this.commentsId, required this.title, required this.profilePic, required this.uploader, required this.hashtag, required this.likes, required this.thumbnails});

  factory Shorts.fromJson(Map<String, dynamic> json) {
    return Shorts(
      shortId: json['shortsId'],
      url: json['url'],
      commentsId: List<String>.from(json['comments']),
      title: json['title'],
      profilePic: json['profilePic'],
      uploader: json['uploader'],
      hashtag: List<String>.from(json['hashtag']),
      likes: json['likes'],
      thumbnails: json['thumbnails']
    );
  }
}

List<Shorts> dummyList = [
  //https://www.youtube.com/shorts/NLjB1GqMzeA
  //HQkSowtWcRc
  //3K6h2Wn0rEI
  //https://www.youtube.com/watch?v=LqME1y6Mlyg
  Shorts(shortId: "1", url: 'HQkSowtWcRc', commentsId: ["3"], title: "4", profilePic: "5", uploader: "6", hashtag: ["7"], likes: 123, thumbnails: "123"),
  Shorts(shortId: "123", url: "3K6h2Wn0rEI", commentsId: ["123"], title: "123", profilePic: "123", uploader: "123", hashtag: ["123"], likes: 123, thumbnails: "123"),
  Shorts(shortId: "123", url: "LqME1y6Mlyg", commentsId: ["123"], title: "123", profilePic: "123", uploader: "123", hashtag: ["123"], likes: 123, thumbnails: "123"),
  Shorts(shortId: "123", url: "NLjB1GqMzeA", commentsId: ["123"], title: "123", profilePic: "123", uploader: "123", hashtag: ["123"], likes: 123, thumbnails: "123"),
];