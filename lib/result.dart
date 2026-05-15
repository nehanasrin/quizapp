import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int totalQuestions;
  final int correctanswer;
  final double percentageScore;
  final Color totalQuestioncolor;
  final Color correctanswercolor;

  Result({
    required this.totalQuestions,
    required this.correctanswer,
    required this.percentageScore,
    required this.totalQuestioncolor,
    required this.correctanswercolor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
            backgroundColor: Colors.white,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("CONGRATULATIONS"),
                SizedBox(height: 10),
                Text(
                  '${percentageScore.toStringAsFixed(2)}%score',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Quiz COMPLETED SUCCESSFULLY!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'YOU ATTEMPTED $totalQuestions questions.',
                  style: TextStyle(fontSize: 18, color: totalQuestioncolor),
                ),
                Text(
                  '$correctanswer answer are correct.',
                  style: TextStyle(fontSize: 18, color: correctanswercolor),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          MaterialButton(
            onPressed: () {
              if (percentageScore < 50) {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(
              percentageScore < 50 ? 'TRY AGAIN...!' : 'BACK...!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            height: 75,minWidth: 180,shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),color: percentageScore<50 ? Colors.red : Colors.green ,textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
