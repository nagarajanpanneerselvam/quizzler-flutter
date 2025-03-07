import 'package:flutter/material.dart';
import 'package:quizzler/QuestionBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuestionBrain questionBrain;

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    questionBrain = QuestionBrain();
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  int score = 0;

  Icon getScoreIcon(bool state) {
    var expectedIcon = state ? Icons.check : Icons.close;
    var expectedColor = state ? Colors.green : Colors.red;
    return Icon(
      expectedIcon,
      color: expectedColor,
    );
  }

  void checkAnswer(bool pressedOption) {
    if (questionBrain.isFinished()) {
      Alert(
              context: context,
              title: "QuizBrain",
              desc:
                  "Your score is $score out of ${questionBrain.getQuestionCount()}")
          .show();
      questionBrain.reset();
      scoreKeeper = [];
      score = 0;
    } else {
      if (questionBrain.getAnswer() == pressedOption) score++;
      scoreKeeper.add(getScoreIcon(questionBrain.getAnswer() == pressedOption));
      questionBrain.nextQuestion();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
