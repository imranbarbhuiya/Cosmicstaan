import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;

  final List<Question> _questionBank = [
    Question(
        'Rising and setting of phenomena the Sun cannot be observed on the surface of the Moon',
        false),
    Question(
        'Venus planets has a revolution time which is shorter than its rotation time',
        true),
    Question('Saturn planet looks reddish in the night sky?', false),
    Question(
        'Sunita Williams female astronaut spent the maximum time in space?',
        true),
    Question('Mercury planet has the fastest revolution time', true),
    Question('An astronaut in outer space will observe sky as White', false),
    Question(
        'March planets rotates in a direction opposite to the direction of earth\'s rotation',
        false),
    Question(
        'The average distance (approximate) between the Sun and the Earth is 150 x 106 km',
        true),
    Question(
        'NASA\'s Deep Impact space mission was employed to take detailed pictures of Tempel 1 comet nucleus.',
        true),
    Question('March planets has a lesser rotation time than the Earth', false),
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
    return _questionBank[_questionNumber].questionAnswer;
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
