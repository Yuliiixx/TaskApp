import 'package:flutter/material.dart';
import 'package:gcitest/db/database_helper.dart';
import 'package:gcitest/model/task_model.dart';
import 'package:gcitest/model/user_model.dart';
import 'package:gcitest/view/login.dart';
import 'package:gcitest/widget/addTaskDialog.dart';
import 'package:gcitest/widget/editTaskDialog.dart';

class TaskScreen extends StatefulWidget {
  final User user;

  TaskScreen({required this.user});

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Task> _tasks = [];
  final TextEditingController _taskController = TextEditingController();
  Map<int, bool> _taskBoxStates = {};

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  void _fetchTasks() async {
    List<Task> tasks = await _databaseHelper.getTasksByUserId(widget.user.id!);
    setState(() {
      _tasks = tasks;
      _taskBoxStates = {for (var task in tasks) task.id!: false};
    });
  }

  void _addTask(String taskText) async {
    Task newTask = Task(userId: widget.user.id!, task: taskText);
    int? result = await _databaseHelper.saveTask(newTask);
    if (result != null && result > 0) {
      _fetchTasks(); // Refresh the task list
      _taskController.clear(); // Clear the text field
    } else {
      // Show error message if save fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add task. Please try again.')),
      );
    }
  }

  void _updateTask(Task task) async {
    int? result = await _databaseHelper.updateTask(task);
    if (result != null && result > 0) {
      _fetchTasks(); // Refresh the task list
    } else {
      // Show error message if update fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update task. Please try again.')),
      );
    }
  }

  void _deleteTask(int taskId) async {
    int? result = await _databaseHelper.deleteTask(taskId);
    if (result != null && result > 0) {
      _fetchTasks(); // Refresh the task list
    } else {
      // Show error message if deletion fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete task. Please try again.')),
      );
    }
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => AddTaskDialog(
        taskController: _taskController,
        onAdd: _addTask,
      ),
    );
  }

  void _showEditTaskDialog(Task task) {
    showDialog(
      context: context,
      builder: (context) => EditTaskDialog(
        taskController: _taskController,
        task: task,
        onUpdate: _updateTask,
      ),
    );
  }

  void _logout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void _showMenuBar() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {
                  Navigator.of(context).pop(); // Close the menu
                  _logout(); // Logout action
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF62D2C3), // Background color
      body: SingleChildScrollView( // Make the entire body scrollable
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset(
                      'images/shape.png', // Add your asset path
                      width: 200,
                      height: 200,
                    ),
                  ),
                  Positioned(
                    top: 40,
                    right: 20,
                    child: GestureDetector(
                      onTap: _showMenuBar,
                      child: Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 120.0), // Adjust the padding to move the profile picture down
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('images/profile.png'), // Add profile picture from asset
                        radius: 40,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Hello, ${widget.user.name}!', // Display name
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20), // Added margin below the name
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Image.asset(
                      'images/jam.png', // Replace with your asset path
                      width: 150,
                      height: 150,
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Task List',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5), // Reduce space below "Task List" text
                    Container(
                      height: 275, // Set a fixed height for the task list container
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Card(
                              color: Colors.white, // Change card color to white
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Daily Task',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Scrollbar(
                                      child: ListView.builder(
                                        padding: EdgeInsets.symmetric(vertical: 2), // Decrease padding between tasks
                                        itemCount: _tasks.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              ListTile(
                                                leading: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _taskBoxStates[_tasks[index].id!] = !_taskBoxStates[_tasks[index].id!]!;
                                                    });
                                                  },
                                                  child: Container(
                                                    width: 20,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                      color: _taskBoxStates[_tasks[index].id!]! ? Color(0xFF62D2C3) : Colors.transparent,
                                                      border: Border.all(color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                                title: Text(_tasks[index].task),
                                                trailing: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(Icons.edit),
                                                      onPressed: () {
                                                        _showEditTaskDialog(_tasks[index]);
                                                      },
                                                    ),
                                                    IconButton(
                                                      icon: Icon(Icons.delete),
                                                      onPressed: () {
                                                        _deleteTask(_tasks[index].id!);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 8), // Add space between tasks
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 16,
                            right: 26,
                            child: GestureDetector(
                              onTap: _showAddTaskDialog,
                              child: Container(
                                child: Center(
                                  child: Icon(
                                    Icons.add_circle_outline,
                                    color: Color(0xFF62D2C3),
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
