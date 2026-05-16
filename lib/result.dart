import 'package:flutter/material.dart';
import 'package:quizapp/main.dart';
import 'package:quizapp/quiz.dart';

class Result extends StatelessWidget {
  final int totalQuestions;
  final int correctanswer;
  final double percentageScore;
  final Color totalQuestioncolor;
  final Color correctanswercolor;

  const Result({
    super.key,
    required this.totalQuestions,
    required this.correctanswer,
    required this.percentageScore,
    required this.totalQuestioncolor,
    required this.correctanswercolor,
  });

  @override
  Widget build(BuildContext context) {
    bool isPassed = percentageScore >= 50;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kBackgroundColor, kSurfaceColor],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                // Achievement Badge/Icon
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: (isPassed ? kSuccessColor : kErrorColor).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isPassed ? Icons.emoji_events : Icons.sentiment_very_dissatisfied,
                    size: 80,
                    color: isPassed ? kAccentColor : kErrorColor,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  isPassed ? "CONGRATULATIONS!" : "KEEP PRACTICING!",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  isPassed ? "You've mastered this quiz." : "You're getting there!",
                  style: const TextStyle(color: kTextSecondary, fontSize: 16),
                ),
                const Spacer(),
                // Score Circle
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 180,
                      height: 180,
                      child: CircularProgressIndicator(
                        value: percentageScore / 100,
                        strokeWidth: 12,
                        backgroundColor: Colors.white10,
                        valueColor: AlwaysStoppedAnimation<Color>(isPassed ? kSuccessColor : kErrorColor),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "${percentageScore.toInt()}%",
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          "SCORE",
                          style: TextStyle(
                            fontSize: 14,
                            color: kTextSecondary,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                // Stats Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: kSurfaceColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem("TOTAL", totalQuestions.toString(), kTextSecondary),
                      Container(width: 1, height: 40, color: Colors.white10),
                      _buildStatItem("CORRECT", correctanswer.toString(), kSuccessColor),
                      Container(width: 1, height: 40, color: Colors.white10),
                      _buildStatItem("WRONG", (totalQuestions - correctanswer).toString(), kErrorColor),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const Quiz()),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          side: const BorderSide(color: kPrimaryColor),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text("TRY AGAIN", style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 0,
                        ),
                        child: const Text("HOME", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: kTextSecondary, letterSpacing: 1),
        ),
      ],
    );
  }
}

