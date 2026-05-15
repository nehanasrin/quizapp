import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quizapp/quiz.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {Future.delayed(Duration(seconds: 3),(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Quiz(),));
  },);
     {
      
    }
    return Scaffold(backgroundColor: Colors.black,body: Center(child:Lottie.asset("assets/question.json")),);
  }
}