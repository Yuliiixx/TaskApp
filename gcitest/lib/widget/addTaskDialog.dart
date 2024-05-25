import 'package:flutter/material.dart';


class AddTaskDialog extends StatelessWidget {
  final TextEditingController taskController;
  final Function(String) onAdd;

  const AddTaskDialog({
    Key? key,
    required this.taskController,
    required this.onAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white, // Background color of the dialog
      title: Text(
        'Add Task',
        style: TextStyle(
          color: Colors.black, // Text color of the title
        ),
      ),
      content: TextField(
        controller: taskController,
        style: TextStyle(color: Colors.black), // Text color of the input field
        decoration: InputDecoration(
          hintText: 'Enter task', // Placeholder text
          hintStyle: TextStyle(color: Colors.grey), // Text color of the placeholder
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
            backgroundColor: Color(0xFF62D2C3), // Background color of the add button
            elevation: 0, // Remove button elevation
          ),
          onPressed: () {
            if (taskController.text.trim().isNotEmpty) {
              onAdd(taskController.text.trim());
              Navigator.of(context).pop(); // Close dialog after adding task
            }
          },
          child: Text(
            'Add',
            style: TextStyle(
              color: Colors.white, // Text color of the add button
            ),
          ),
        ),
      ],
    );
  }
}
