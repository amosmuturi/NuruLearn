class ResultScreen extends StatelessWidget {
final int score;
final int total;
const ResultScreen({Key? key, required this.score, required this.total}) : super(key: key);


String get message {
final pct = (score / total) * 100;
if (pct == 100) return 'Perfect! 100% — Excellent work.';
if (pct >= 70) return 'Great job! Keep it up.';
if (pct >= 50) return 'Good attempt. Revise and try again.';
return 'Keep practicing — you will improve!';
}


@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('Result')),
body: Center(
child: Padding(
padding: const EdgeInsets.all(24.0),
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
Text('$score / $total', style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold)),
const SizedBox(height: 12),
Text(message, style: const TextStyle(fontSize: 16), textAlign: TextAlign.center),
const SizedBox(height: 24),
Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
ElevatedButton(
onPressed: () {
// restart: go home
Navigator.pushAndRemoveUntil(
context,
MaterialPageRoute(builder: (_) => const HomeScreen()),
(route) => false,
);
},
child: const Text('Home'),
),
const SizedBox(width: 12),
OutlinedButton(
onPressed: () {
// retake: navigate back to home and into the same lesson? Simpler: go home and let user re-enter
Navigator.pushAndRemoveUntil(
context,
MaterialPageRoute(builder: (_) => const HomeScreen()),
(route) => false,
);
},
child: const Text('Retake'),
)
],
)
],
),
),
),
);
}
}