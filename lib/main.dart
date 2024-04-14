import 'package:flutter/material.dart';
import 'package:myquizapp/questions_bank.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: const Padding(
          padding: EdgeInsets.all(18.0),
          child: QuizPage(),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // Function to show the alert with custom cancel button text
  void showCustomAlert(BuildContext context) {
    Alert(
      context: context,
      type: AlertType.success,
      title: "ALERT",
      desc: "You are about to close this alert.",
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          color: const Color.fromRGBO(0, 179, 134, 1.0),
          child: const Text(
            "Cancel", // Custom text for the cancel button
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        DialogButton(
          onPressed: () {
            // Your proceed action
            Navigator.pop(context);
          },
          gradient: const LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
          child: const Text(
            "Finished",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  String _list = '😊';
  int _totalScore = 0;
  List<Icon> _scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      if (quizBrain.isFinished() == true) {
        showCustomAlert(context);
        // Alert(
        //   context: context,
        //   title: 'Finished!',
        //   desc:
        //       'You\'ve reached the end of the quiz and Your Score is $_totalScore',
        // ).show();
        quizBrain.reset();
        _scoreKeeper = [];
        _totalScore = 0;
        _list = '😊';
      } else {
        if (userPickedAnswer == correctAnswer) {
          _scoreKeeper.add(
            const Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
          _totalScore++;
          _list = '😊';
        } else {
          _scoreKeeper.add(
            const Icon(
              Icons.close,
              color: Colors.red,
            ),
          );

          _list = '😢';
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          /// questions
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          /// emoji

          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                _list,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 100.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          /// score
          Expanded(
            //flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '$_totalScore/10',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          /// buttons
          // true
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.all(16.0),
                ),
                onPressed: () {
                  checkAnswer(true);
                },
                child: const SizedBox(
                  width: double
                      .infinity, // Force the button to take all available width
                  child: Text(
                    'True',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // False
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.all(16.0),
                ),
                onPressed: () {
                  checkAnswer(false);
                },
                child: const SizedBox(
                  width: double
                      .infinity, // Force the button to take all available width
                  child: Text(
                    'False',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// trackers
          Row(
            children: _scoreKeeper,
          ),
        ],
      ),
    );
  }
}
