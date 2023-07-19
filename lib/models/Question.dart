class Question {
  String qId; // 고유 id
  String q; // 질문 내용
  List<String> a; // 답변에 들어가야 하는 키워드들의 리스트. 이 중 하나만 있어도 pass
  String shortsId; // 영상 url

  Question({
    required this.qId,
    required this.q,
    required this.a,
    required this.shortsId,
  });
}

List<Question> dummyList = [
  Question(
    qId: "1",
    q: "영상에서 나오는 고양이의 이름은 무엇인가요?",
    a: ["고양이 이름", "고양이 이름 알려줘"],
    shortsId: "64b664db02556d36075b28c0", //내용은 아직 수정안했음
  ),
  Question(
    qId: "2",
    q: "이 영상은 어떤 주제로 제작되었나요?",
    a: ["주제", "영상 주제", "주제 알려줘"],
    shortsId: "3K6h2Wn0rEI",
  ),
  Question(
    qId: "3",
    q: "영상의 업로더는 누구인가요?",
    a: ["업로더", "영상 업로더", "업로더 이름"],
    shortsId: "LqME1y6Mlyg",
  ),
  Question(
    qId: "4",
    q: "해당 영상의 좋아요 수는 얼마인가요?",
    a: ["좋아요 수", "좋아요 개수"],
    shortsId: "NLjB1GqMzeA",
  ),
];
