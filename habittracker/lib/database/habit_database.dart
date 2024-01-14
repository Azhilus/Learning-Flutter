import 'package:flutter/material.dart';
import 'package:habittracker/models/app_settings.dart';
import 'package:habittracker/models/habit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;
  /*

  S E T U P

  */

  // I N I T I A L I Z E - D A T A B A S E
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar =
        await Isar.open([HabitSchema, AppSettingsSchema], directory: dir.path);
  }

  // Save first date of app startup (for heatmap)
  Future<void> saveFirstLaunchDate() async {
    final existingSettings = await isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final settings = AppSettings()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
  }

  // Get first date of app startup (for heatmap)
  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }
  /*
  
  C R U D X O P E R A T I O N S

  */

  // List of habits
  final List<Habit> currentHabits = [];
  // C R E A T E - add a new habit
  Future<void> addHabit(String name) async {
    final habit = Habit()..name = name;
    await isar.writeTxn(() => isar.habits.put(habit));
    readHabits();
  }

  // R E A D - read saved habits from db
  Future<void> readHabits() async {
    final habits = await isar.habits.where().findAll();
    currentHabits.clear();
    currentHabits.addAll(habits);

    notifyListeners();
  }

  // U P D A T E - check habit on and off
  Future<void> updateHabitCompletion(int id, bool isCompleted) async {
    final habit = await isar.habits.get(id);

    if (habit != null) {
      await isar.writeTxn(() async {
        if (isCompleted && !habit.completedDays.contains(DateTime.now())) {
          final today = DateTime.now();

          // Add today to completed days
          habit.completedDays.add(
            DateTime(today.year, today.month, today.day),
          );
        } else {
          habit.completedDays.removeWhere(

              // Remove today from completed days
              (date) =>
                  date.year == DateTime.now().year &&
                  date.month == DateTime.now().month &&
                  date.day == DateTime.now().day);
        }
        await isar.habits.put(habit);
      });
    }
  }

  // U P D A T E - edit habit
  Future<void> updateHabitName(int id, String newName) async {
    final habit = await isar.habits.get(id);

    if (habit != null) {
      await isar.writeTxn(() async {
        habit.name = newName;
        await isar.habits.put(habit);
      });
    }

    readHabits();
  }

  // D E L E T E - delete habit
  Future<void> deleteHabit(int id) async {
    await isar.writeTxn(() async {
      await isar.habits.delete(id);
    });

    readHabits();
  }

  void createHabit(String newHabitName) {}
}
