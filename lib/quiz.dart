import 'package:flutter/material.dart';
import 'package:quizapp/qlist.dart';
import 'package:quizapp/result.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  late PageController pageview;
  late List<String?> userAns;
  @override
  void initState() {
    super.initState();
    pageview = PageController();
    userAns = List.filled(quizapp.length, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: pageview,
        itemCount: quizapp.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(color: const Color.fromARGB(255, 21, 23, 23)),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      quizapp[index]['question'],
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 30,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: List.generate(quizapp[index]['options'].length, (
                      optionindex,
                    ) {
                      String options = quizapp[index]['options'][optionindex];

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            userAns[index] = options;
                          });
                        },
                        child: Container(
                          height: 45,
                          width: 300,
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color.fromARGB(0, 3, 3, 3)),
                            color: _getoptioncolor(options, index),
                          ),
                          child: Center(
                            child: Text(
                              options,
                              style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 18,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 20),
                  MaterialButton(
                    onPressed: () {
                      if (index < quizapp.length - 1) {
                        pageview.nextPage(
                          duration: Duration(seconds: 1),
                          curve: Curves.ease,
                        );
                      } else {showResult();}
                    },
                    color: Colors.white,
                    height: 65,
                    minWidth: 140,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      index < quizapp.length - 1 ? "next" : "submit",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getoptioncolor(String option, int index) {
    if (userAns[index] != null) {
      if (quizapp[index]['correctanswer'] == option) {
        return Colors.green;
      } else if (userAns[index] == option) {
        return Colors.red;
      } else {
        return Colors.transparent;
      }
    }
    return Colors.transparent;
  }

  void showResult() {
    int totalQuestions = quizapp.length;
    int correctanswer = 0;

    for (int i = 0; i < totalQuestions; i++) {
      if (userAns[i] == quizapp[i]['correctanswer']) {
        correctanswer++;
      }
    }
    double percentageScore = (correctanswer / totalQuestions) * 100;

    Color totalQuestioncolor = Colors.red;
    Color correctanswercolor = Colors.green;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => Result(
              totalQuestions: totalQuestions,
              correctanswer: correctanswer,
              percentageScore: percentageScore,
              totalQuestioncolor: totalQuestioncolor,
              correctanswercolor: correctanswercolor,
            ),
      ),
    );
  }
}
