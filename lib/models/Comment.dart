class Comment {
  String commentId;
  String userId;
  String comment;
  String profileUrl;

  Comment({required this.commentId, required this.userId, required this.comment, required this.profileUrl});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      commentId: json['commentId'],
      userId: json['userId'],
      comment: json['comment'],
      profileUrl: json['profileUrl'],
    );
  }
}

List<Comment> dummyComments = [
  Comment(commentId: "123", userId: "123", comment: "123", profileUrl: "123"),
  Comment(commentId: "123", userId: "123", comment: "123",profileUrl: "123"),
  Comment(commentId: "123", userId: "123", comment: "123",profileUrl: "123"),
  Comment(commentId: "123", userId: "123", comment: "123",profileUrl: "123"),
  Comment(commentId: "123", userId: "123", comment: "123",profileUrl: "123"),
];