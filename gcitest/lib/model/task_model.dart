class Task {
  int? id;
  int userId;
  String task;

  Task({
    this.id,
    required this.userId,
    required this.task,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'task': task,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      userId: map['userId'],
      task: map['task'],
    );
  }
}

