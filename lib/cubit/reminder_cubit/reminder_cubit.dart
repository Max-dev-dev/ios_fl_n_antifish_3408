import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_fl_n_antifish_3408/model/reminder_model/reminder_model.dart';

class ReminderCubit extends Cubit<List<ReminderModel>> {
  ReminderCubit() : super([]);

  void addReminder(ReminderModel reminder) {
    emit([...state, reminder]);
  }
}