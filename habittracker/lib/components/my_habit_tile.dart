import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../models/checkbox_state.dart';

class MyHabitTile extends StatelessWidget {
  final String text;
  final void Function(bool?) onChanged;
  final void Function(BuildContext)? editHabit;
  final void Function(BuildContext)? deleteHabit;
  final bool isCompleted;

  const MyHabitTile({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.editHabit,
    required this.deleteHabit,
    required this.isCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HabitModel(),
      child: _MyHabitTileContent(
        text: text,
        onChanged: onChanged,
        editHabit: editHabit,
        deleteHabit: deleteHabit,
        isCompleted: isCompleted, // Pass isCompleted here
      ),
    );
  }
}

class _MyHabitTileContent extends StatelessWidget {
  final String text;
  final void Function(bool?) onChanged;
  final void Function(BuildContext)? editHabit;
  final void Function(BuildContext)? deleteHabit;
  final bool isCompleted; // Receive isCompleted as a parameter

  const _MyHabitTileContent({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.editHabit,
    required this.deleteHabit,
    required this.isCompleted, // Declare isCompleted here
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HabitModel habitModel = Provider.of<HabitModel>(context);

    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: editHabit,
            backgroundColor: Colors.grey.shade800,
            icon: Icons.settings,
            borderRadius: BorderRadius.circular(8),
          ),
          SlidableAction(
            onPressed: deleteHabit,
            backgroundColor: Colors.red,
            icon: Icons.delete,
            borderRadius: BorderRadius.circular(8),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          habitModel.isChecked = !habitModel.isChecked;
          onChanged(habitModel.isChecked);
        },
        child: Container(
          decoration: BoxDecoration(
            color: habitModel.isChecked
                ? Colors.green
                : Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 5,
          ),
          child: ListTile(
            title: Text(
              text,
              style: TextStyle(
                color: isCompleted
                    ? Colors.white
                    : Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            leading: Checkbox(
              activeColor: Colors.green,
              value: habitModel.isChecked,
              onChanged: (value) {
                habitModel.isChecked = value!;
                onChanged(value);
              },
            ),
          ),
        ),
      ),
    );
  }
}
