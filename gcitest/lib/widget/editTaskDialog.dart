import 'package:flutter/material.dart';
import 'package:gcitest/model/task_model.dart';

class EditTaskDialog extends StatelessWidget {
  final TextEditingController taskController;
  final Task task;
  final Function(Task) onUpdate;

  const EditTaskDialog({
    Key? key,
    required this.taskController,
    required this.task,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    taskController.text = task.task;
    return AlertDialog(
      backgroundColor: Colors.white, // Background color of the dialog
      title: Text(
        'Edit Task',
        style: TextStyle(
          color: Colors.black, // Text color of the title
        ),
      ),
      content: TextField(
        controller: taskController,
        style: TextStyle(color: Colors.black), // Text color of the input field
        decoration: InputDecoration(
          labelText: 'Task', // Label text
          labelStyle: TextStyle(color: Colors.black), // Text color of the label
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.black), // Border color
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.black, // Text color of the cancel button
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF62D2C3), // Background color of the save button
            elevation: 0, // Remove button elevation
          ),
          onPressed: () {
            if (taskController.text.trim().isNotEmpty) {
              task.task = taskController.text.trim();
              onUpdate(task);
              Navigator.of(context).pop(); // Close dialog after updating task
            }
          },
          child: Text(
            'Save',
            style: TextStyle(
              color: Colors.white, // Text color of the save button
            ),
          ),
        ),
      ],
    );
  }
}
