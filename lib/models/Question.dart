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
    q: "배고프다고? 나 쳐다본다고 밥이 나오니? 가서 밥을 시켜",
    a: ["T","t"],
    shortsId: "64b763289de093928a11da1d",
  ),
  Question(
    qId: "2",
    q: "오빠~! 이 차 너무 멋있다~! ㅠㅠㅠ 이거 구하기도 힘든건데 어디서 구했어?",
    a: ["아는", "형님", "누나"],
    shortsId: "64b7627f9de093928a11da05",
  ),
  Question(
    qId: "3",
    q: "허윤진 널 좋아해..",
    a: ["하지만", "하우에버"],
    shortsId: "64b762e99de093928a11da11",
  ),
  Question(
    qId: "4",
    q: "어 남친이 ㅎ, 갤러리아 갔다가 내 생각이 났대",
    a: ["이사라", "남친"],
    shortsId: "64b762dc9de093928a11da0e",
  ),
];
