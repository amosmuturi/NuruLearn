import 'package:flutter/material.dart';
import '../models/lesson.dart';
import '../widgets/answer_button.dart';
import 'result_screen.dart';

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
    if (selectedIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please answer the question"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (currentQuestion < widget.lesson.questions.length - 1) {
      setState(() {
        currentQuestion++;
        selectedIndex = null;
        isLocked = false;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            score: score,
            total: widget.lesson.questions.length,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.lesson.questions[currentQuestion];
    final total = widget.lesson.questions.length;
    final progress = (currentQuestion + 1) / total;
    final percent = (progress * 100).toInt();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Quiz: ${widget.lesson.title}"),
        backgroundColor: const Color(0xFF0066CC),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Progress bar + percentage
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey.shade400,
                    color: const Color(0xFF28A745),
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
            // Answer buttons
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
            const SizedBox(height: 16),
            // Next button
            Center(
              child: SizedBox(
                width: 150, // button width
                height: 45, // button height
                child: ElevatedButton(
                  onPressed: nextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF28A745),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
