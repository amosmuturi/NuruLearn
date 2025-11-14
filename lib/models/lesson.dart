

// ---------------- Models ----------------
class Lesson {
final int id;
final String title;
final String image;
final String content;
final List<Question> questions;


Lesson({
required this.id,
required this.title,
required this.image,
required this.content,
required this.questions,
});


factory Lesson.fromJson(Map<String, dynamic> json) {
var q = (json['questions'] as List<dynamic>).map((e) => Question.fromJson(e)).toList();
return Lesson(
id: json['id'],
title: json['title'],
image: json['image'],
content: json['content'],
questions: q,
);
}
}


class Question {
final String question;
final List<String> options;
final int answer; // index


Question({required this.question, required this.options, required this.answer});


factory Question.fromJson(Map<String, dynamic> json) {
return Question(
question: json['question'],
options: List<String>.from(json['options']),
answer: json['answer'],
);
}
}