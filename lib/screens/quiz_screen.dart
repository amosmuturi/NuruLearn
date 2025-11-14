import 'package:flutter/material.dart';
import '../models/lesson.dart';
import '../widgets/answer_button.dart';

class QuizScreen extends StatefulWidget {
  final Lesson lesson;
  const QuizScreen({super.key, required this.lesson});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;
  bool isLocked = false;
  int score = 0;
  int? selectedIndex;
  bool showResult = false;

  void selectAnswer(int index) {
    if (isLocked) return;

    setState(() {
      selectedIndex = index;
      isLocked = true;

      if (index == widget.lesson.questions[currentQuestion].answer) {
        score++;
      }
    });
  }

  void nextQuestion() {
    setState(() {
      if (currentQuestion < widget.lesson.questions.length - 1) {
        currentQuestion++;
        selectedIndex = null;
        isLocked = false;
      } else {
        showResult = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.lesson.questions[currentQuestion];
    final total = widget.lesson.questions.length;
    final progress = (currentQuestion + 1) / total;
    final percent = (progress * 100).toInt();

    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz: ${widget.lesson.title}"),
        backgroundColor: const Color(0xFF0066CC),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: showResult
            ? Center(
                child: AnimatedOpacity(
                  opacity: 1.0,
                  duration: const Duration(seconds: 1),
                  child: Text(
                    "Score: $score / $total",
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0066CC),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Progress bar + percentage
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.grey.shade300,
                          color: const Color(0xFF0066CC),
                          minHeight: 8,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "$percent%",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Question number + text
                  Text(
                    "Question ${currentQuestion + 1}/$total:",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    question.question,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ...List.generate(
                    question.options.length,
                    (index) => AnswerButton(
                      answerText: question.options[index],
                      isCorrect: index == question.answer,
                      isSelected: selectedIndex == index,
                      isLocked: isLocked,
                      showCorrect: isLocked,
                      onTap: () => selectAnswer(index),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (isLocked)
                    ElevatedButton(
                      onPressed: nextQuestion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0066CC),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
