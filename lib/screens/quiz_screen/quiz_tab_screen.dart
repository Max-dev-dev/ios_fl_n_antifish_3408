import 'dart:async';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ios_fl_n_antifish_3408/model/question_model/question_model.dart';

class QuizTabScreen extends StatefulWidget {
  const QuizTabScreen({super.key});

  @override
  State<QuizTabScreen> createState() => _QuizTabScreenState();
}

class _QuizTabScreenState extends State<QuizTabScreen> {
  int currentIndex = 0;
  int correctAnswers = 0;
  int? selectedIndex;
  bool? isCorrect;
  bool showResult = false;
  bool finished = false;
  late Timer _timer;
  int _elapsedSeconds = 0;

  final List<QuestionModel> allQuestions = [
    QuestionModel(
      question: 'What is phishing?',
      options: [
        'Fishing in a river',
        'Sending fake messages to steal data',
        'Tracking website visits',
      ],
      correctIndex: 1,
      explanation:
          'Phishing is a cyberattack where attackers trick users into giving up personal info via fake emails or websites.',
    ),
    QuestionModel(
      question: 'Which password is strongest?',
      options: ['123456', 'iloveyou', 'gH7\$kL2!pZ'],
      correctIndex: 2,
      explanation:
          'Strong passwords are long, use a mix of characters, and avoid common patterns.',
    ),
    QuestionModel(
      question:
          'What should you do if you receive a suspicious email with a link?',
      options: [
        'Click it to see what it is',
        'Delete or report it',
        'Forward it to a friend',
      ],
      correctIndex: 1,
      explanation:
          'Never click suspicious links. Report or delete such emails immediately.',
    ),
    QuestionModel(
      question: 'What is two-factor authentication (2FA)?',
      options: [
        'Using two passwords',
        'Logging in from two devices',
        'Using an extra code after your password',
      ],
      correctIndex: 2,
      explanation:
          '2FA adds a second layer of protection by requiring a code sent to your phone or email.',
    ),
    QuestionModel(
      question: 'Should you use the same password on multiple sites?',
      options: [
        'Yes, it’s easier',
        'Only for social media',
        'No, it increases your risk',
      ],
      correctIndex: 2,
      explanation:
          'If one account is breached, reused passwords can compromise your other accounts too.',
    ),
    QuestionModel(
      question: 'What does a secure website URL start with?',
      options: ['http://', 'ftp://', 'https://'],
      correctIndex: 2,
      explanation:
          '“https” means the website uses encryption to protect your data.',
    ),
    QuestionModel(
      question: 'What is a password manager?',
      options: [
        'A tool for remembering birthdays',
        'A browser extension for autofill',
        'An app that stores and generates secure passwords',
      ],
      correctIndex: 2,
      explanation:
          'Password managers help create and manage strong passwords securely.',
    ),
    QuestionModel(
      question: 'What is malware?',
      options: [
        'A type of computer hardware',
        'Harmful software designed to damage or steal data',
        'A virus scanner',
      ],
      correctIndex: 1,
      explanation:
          'Malware includes viruses, spyware, ransomware, and other harmful programs.',
    ),
    QuestionModel(
      question: 'Which action can reduce the risk of identity theft?',
      options: [
        'Sharing login info with friends',
        'Posting personal info online',
        'Using strong passwords and 2FA',
      ],
      correctIndex: 2,
      explanation:
          'Keeping your personal data private and secure protects you from identity theft.',
    ),
    QuestionModel(
      question: 'How often should you change your passwords?',
      options: [
        'Every 5 years',
        'Only if something goes wrong',
        'Every few months or when security is at risk',
      ],
      correctIndex: 2,
      explanation:
          'Regular password changes help reduce the risk if your data is compromised.',
    ),
    QuestionModel(
      question: 'What’s a common sign of a phishing email?',
      options: [
        'A funny subject line',
        'Poor grammar and urgent language',
        'An email from your friend',
      ],
      correctIndex: 1,
      explanation:
          'Phishing emails often have urgent messages and errors to pressure users into acting fast.',
    ),
    QuestionModel(
      question: 'What should you do before downloading a new app?',
      options: [
        'Download it if it looks fun',
        'Check reviews and permissions',
        'Ask a friend',
      ],
      correctIndex: 1,
      explanation:
          'Always review app sources and permissions to avoid installing malicious software.',
    ),
  ];

  late List<QuestionModel> questions;

  @override
  void initState() {
    super.initState();
    questions = allQuestions..shuffle();
    questions = questions.take(12).toList();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _elapsedSeconds++);
    });
  }

  void _checkAnswer(int index) {
    setState(() {
      selectedIndex = index;
      isCorrect = questions[currentIndex].correctIndex == index;
      if (isCorrect!) correctAnswers++;
      showResult = true;
    });
  }

  void _next() {
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
        selectedIndex = null;
        showResult = false;
        isCorrect = null;
      });
    } else {
      setState(() => finished = true);
      _timer.cancel();
    }
  }

  void _restart() {
    setState(() {
      currentIndex = 0;
      correctAnswers = 0;
      selectedIndex = null;
      isCorrect = null;
      showResult = false;
      finished = false;
      _elapsedSeconds = 0;
      questions.shuffle();
    });
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentIndex];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child:
            finished
                ? _buildFinalResult()
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.help_outline,
                          color:
                              isCorrect == true
                                  ? Colors.green
                                  : isCorrect == false
                                  ? Colors.red
                                  : Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            showResult
                                ? 'Question ${currentIndex + 1}/${allQuestions.length} - ${isCorrect! ? 'CORRECT' : 'INCORRECT'}'
                                : 'Question ${currentIndex + 1} - ${question.question}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (!showResult) ...[
                      const SizedBox(height: 50),
                      ...List.generate(
                        question.options.length,
                        (i) => _buildOption(question.options[i], i),
                      ),
                      const SizedBox(height: 50),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed:
                              selectedIndex == null
                                  ? null
                                  : () => _checkAnswer(selectedIndex!),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                selectedIndex != null
                                    ? const Color(0xFFFF6A00)
                                    : const Color(0xFF2E2E2E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Next',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color:
                                  selectedIndex != null
                                      ? Colors.white
                                      : Colors.white54,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _formatTime(_elapsedSeconds),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ] else ...[
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF101A30),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          question.explanation,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: _next,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF6A00),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Next question',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
      ),
    );
  }

  Widget _buildOption(String text, int index) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: showResult ? null : () => setState(() => selectedIndex = index),
      child: Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF101A30),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildFinalResult() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.help_outline, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Test Passed',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF101A30),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'Right answers: $correctAnswers/${allQuestions.length}',
            style: const TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: double.infinity,
          height: 60.0,
          child: ElevatedButton(
            onPressed: _restart,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6A00),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'One more time',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 60.0,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6A00),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Back to Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        TextButton(
          onPressed:
              () => Share.share(
                'I scored $correctAnswers/5 in the Cybersecurity Quiz!',
              ),
          child: const Text(
            'Share',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}
