import 'package:flutter/material.dart';
import 'package:quizapp/qlist.dart';
import 'package:quizapp/result.dart';
import 'package:quizapp/main.dart';

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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kBackgroundColor, kSurfaceColor],
          ),
        ),
        child: SafeArea(
          child: PageView.builder(
            controller: pageview,
            physics: const NeverScrollableScrollPhysics(), // Prevent swiping without answering
            itemCount: quizapp.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
                child: Column(
                  children: [
                    // Progress Indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Question ${index + 1}/${quizapp.length}",
                          style: const TextStyle(
                            color: kTextSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: kPrimaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Score: ${_calculateCurrentScore()}",
                            style: const TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    LinearProgressIndicator(
                      value: (index + 1) / quizapp.length,
                      backgroundColor: Colors.white10,
                      valueColor: const AlwaysStoppedAnimation<Color>(kPrimaryColor),
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    const Spacer(),
                    // Question Card
                    Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: kSurfaceColor,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white.withOpacity(0.05)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Text(
                        quizapp[index]['question'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Options
                    Expanded(
                      flex: 6,
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: quizapp[index]['options'].length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, optionindex) {
                          String option = quizapp[index]['options'][optionindex];
                          bool isSelected = userAns[index] == option;
                          bool isCorrect = quizapp[index]['correctanswer'] == option;
                          bool hasAnswered = userAns[index] != null;

                          return GestureDetector(
                            onTap: hasAnswered ? null : () {
                              setState(() {
                                userAns[index] = option;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                              decoration: BoxDecoration(
                                color: _getOptionBgColor(option, index),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: _getOptionBorderColor(option, index),
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white24),
                                      color: isSelected ? Colors.white : Colors.transparent,
                                    ),
                                    child: Center(
                                      child: isSelected 
                                        ? Icon(
                                            isCorrect ? Icons.check : Icons.close,
                                            size: 18,
                                            color: isCorrect ? kSuccessColor : kErrorColor,
                                          )
                                        : Text(
                                            String.fromCharCode(65 + optionindex),
                                            style: const TextStyle(fontSize: 12, color: kTextSecondary),
                                          ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Text(
                                      option,
                                      style: TextStyle(
                                        color: isSelected ? Colors.white : kTextSecondary,
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const Spacer(),
                    // Action Button
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: userAns[index] == null 
                          ? null 
                          : () {
                              if (index < quizapp.length - 1) {
                                pageview.nextPage(
                                  duration: const Duration(milliseconds: 600),
                                  curve: Curves.easeInOutQuart,
                                );
                              } else {
                                showResult();
                              }
                            },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: kPrimaryColor.withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          index < quizapp.length - 1 ? "NEXT QUESTION" : "VIEW RESULTS",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  int _calculateCurrentScore() {
    int score = 0;
    for (int i = 0; i < userAns.length; i++) {
      if (userAns[i] != null && userAns[i] == quizapp[i]['correctanswer']) {
        score++;
      }
    }
    return score;
  }

  Color _getOptionBgColor(String option, int index) {
    if (userAns[index] == null) return kSurfaceColor;
    
    if (quizapp[index]['correctanswer'] == option) {
      return kSuccessColor.withOpacity(0.1);
    } else if (userAns[index] == option) {
      return kErrorColor.withOpacity(0.1);
    }
    return kSurfaceColor;
  }

  Color _getOptionBorderColor(String option, int index) {
    if (userAns[index] == null) return Colors.white.withOpacity(0.1);
    
    if (quizapp[index]['correctanswer'] == option) {
      return kSuccessColor;
    } else if (userAns[index] == option) {
      return kErrorColor;
    }
    return Colors.white.withOpacity(0.05);
  }

  void showResult() {
    int totalQuestions = quizapp.length;
    int correctanswer = _calculateCurrentScore();
    double percentageScore = (correctanswer / totalQuestions) * 100;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Result(
          totalQuestions: totalQuestions,
          correctanswer: correctanswer,
          percentageScore: percentageScore,
          totalQuestioncolor: kTextSecondary,
          correctanswercolor: kSuccessColor,
        ),
      ),
    );
  }
}

