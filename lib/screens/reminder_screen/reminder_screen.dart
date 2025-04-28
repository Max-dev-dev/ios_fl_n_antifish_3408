import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_fl_n_antifish_3408/cubit/reminder_cubit/reminder_cubit.dart';
import 'package:ios_fl_n_antifish_3408/model/reminder_model/reminder_model.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  int _selectedInterval = 40;

  void _submitReminder() {
    final title = _titleController.text.trim();
    final description = _descController.text.trim();
    final interval = _selectedInterval;

    if (title.isEmpty || description.isEmpty || interval == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields to continue.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final reminder = ReminderModel(
      title: title,
      description: description,
      intervalDays: interval,
      createdAt: DateTime.now(),
    );

    context.read<ReminderCubit>().addReminder(reminder);

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: const Color(0xFF0B172A),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/reminder_added_icon.png',
                  width: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Security reminder was added successfully',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: const Color(0xFFFF6A00),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
    );

    _titleController.clear();
    _descController.clear();
    _selectedInterval = 40;
    setState(() {});
  }

  bool get _isFormValid {
    return _titleController.text.trim().isNotEmpty &&
        _descController.text.trim().isNotEmpty &&
        _selectedInterval != 0;
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFF101A30),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      hintStyle: const TextStyle(color: Colors.white54),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Title:', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 4),
            TextField(
              controller: _titleController,
              decoration: _inputDecoration('Type your title'),
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            const Text('Description:', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 4),
            TextField(
              controller: _descController,
              decoration: _inputDecoration('Description'),
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            const Text('Interval:', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children:
                  [20, 40, 60].map((day) {
                    final selected = _selectedInterval == day;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedInterval = day),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color:
                              selected
                                  ? const Color(0xFFFF6A00)
                                  : const Color(0xFF101A30),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '$day days',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isFormValid
                          ? const Color(0xFFFF6A00)
                          : const Color(0xFFFF6A00).withOpacity(0.5),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _submitReminder,
                child: const Text(
                  'Add reminder',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}
