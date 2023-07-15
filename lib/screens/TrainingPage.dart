import 'package:flutter/material.dart';
import 'package:flutter2/widgets/ChatBubble.dart';
import 'package:ninepatch_image/ninepatch_image.dart';
import '../models/Question.dart';

class TrainingPage extends StatefulWidget {
  @override
  _TrainingPageState createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  int currentQuestionIndex = 0;
  List<String> answeredQuestions = [];
  String currentAnswer = ''; // Declare and initialize currentAnswer variable

  final ScrollController _scrollController = ScrollController(); // Create ScrollController instance

  void submitAnswer(String answer) {
    final currentQuestion = dummyList[currentQuestionIndex];
    final isCorrect = currentQuestion.a.any((keyword) => answer.contains(keyword));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isCorrect ? 'O' : 'X'),
          content: Text('Answer: $answer'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                moveToNextQuestion();
              },
              child: Text('Next Question'),
            ),
          ],
        );
      },
    );
  }

  void moveToNextQuestion() {
    setState(() {
      currentQuestionIndex = (currentQuestionIndex + 1) % dummyList.length;
      answeredQuestions.add(currentAnswer);
      currentAnswer = '';
    });

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollController.animateTo( // Scroll to the bottom of ListView
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose the ScrollController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = dummyList[currentQuestionIndex];

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/chatbackground.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10.0), // 좌우 패딩 적용
                  controller: _scrollController,
                  itemCount: answeredQuestions.length * 2 + 1,
                  itemBuilder: (context, index) {
                    if (index.isOdd) {
                      final answerIndex = (index ~/ 2);
                      final answer = answeredQuestions[answerIndex];

                      return Padding(
                          padding: const EdgeInsets.only(bottom: 3.0),
                          child: ChatBubble(answer, true)
                      );
                    } else {
                      final questionIndex = (index ~/ 2);
                      final question = dummyList[questionIndex];

                      return Padding(
                          padding: const EdgeInsets.only(bottom: 3.0),
                          child: ChatBubble(question.q,false)
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      margin: EdgeInsets.only(left:10,bottom: 10,top: 10),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            currentAnswer = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: '정답을 입력하세요',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          filled: true,
                          fillColor: Colors.white
                        ),
                      ),
                    )
                  ),
                  SizedBox(width: 8.0),
                  GestureDetector(
                    onTap: () {
                      submitAnswer(currentAnswer);
                    },
                    child: Image.asset(
                      'images/arrow.png',
                      width: 32.0,
                      height: 32.0,
                    ),
                  ),
                  SizedBox(width: 8.0)
                ],
              ),
            ],
          ),
        ),
      ),
    );


    // return Container(
    //   decoration: BoxDecoration(
    //     image: DecorationImage(
    //       image: AssetImage("images/chatbackground.png"),
    //       fit: BoxFit.cover,
    //     ),
    //   ),
    //   child: Column(
    //     children: [
    //       Expanded(
    //         child: ListView.builder(
    //           padding: EdgeInsets.symmetric(horizontal: 30.0), // 좌우 패딩 적용
    //           controller: _scrollController, // Assign ScrollController to ListView
    //           itemCount: answeredQuestions.length * 2 + 1,
    //           itemBuilder: (context, index) {
    //             if (index.isOdd) {
    //               final answerIndex = (index ~/ 2);
    //               final answer = answeredQuestions[answerIndex];
    //
    //               return Padding(
    //                 padding: const EdgeInsets.only(bottom: 3.0),
    //                 child: ChatBubble(answer, true)
    //               );
    //             } else {
    //               final questionIndex = (index ~/ 2);
    //               final question = dummyList[questionIndex];
    //
    //               return Padding(
    //                 padding: const EdgeInsets.only(bottom: 3.0),
    //                 child: ChatBubble(question.q,false)
    //               );
    //             }
    //           },
    //         ),
    //       ),
    //       SizedBox(height: 8.0),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Expanded(
    //             child: TextField(
    //               onChanged: (value) {
    //                 setState(() {
    //                   currentAnswer = value;
    //                 });
    //               },
    //               decoration: InputDecoration(
    //                 labelText: '정답을 입력하세요',
    //                 border: OutlineInputBorder(),
    //               ),
    //             ),
    //           ),
    //           SizedBox(width: 8.0),
    //           GestureDetector(
    //             onTap: () {
    //               submitAnswer(currentAnswer);
    //             },
    //             child: Image.asset(
    //               'images/arrow.png',
    //               width: 32.0,
    //               height: 32.0,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}
