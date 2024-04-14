import 'package:myquizapp/questions.dart';

class QuizBrain {
  int _questionNumber = 0;

  final List<Question> _questionBank = [
    Question(
      questionText:
          'The Earth is the only planet in our solar system that has liquid water?',
      questionAns: true,
    ),
    Question(
      questionText: 'Sound travels faster in air than in water?',
      questionAns: false,
    ),
    Question(
      questionText: 'The Great Wall of China is visible from the moon?',
      questionAns: false,
    ),
    Question(
      questionText: 'Vitamin C is also known as ascorbic acid?',
      questionAns: true,
    ),
    Question(
      questionText: 'Sharks are mammals?',
      questionAns: false,
    ),
    Question(
      questionText: 'The human body has four lungs?',
      questionAns: false,
    ),
    Question(
      questionText: 'The currency of Switzerland is the Euro?',
      questionAns: false,
    ),
    Question(
      questionText:
          'Albert Einstein was awarded the Nobel Prize in Physics in 1921 for his theory of relativity?',
      questionAns: false,
    ),
    Question(
      questionText: 'Lightning never strikes in the same place twice?',
      questionAns: false,
    ),
    Question(
      questionText: 'The capital of Australia is Sydney?',
      questionAns: false,
    ),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAns;
  }

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }
}
