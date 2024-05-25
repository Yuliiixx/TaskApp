import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:gcitest/model/user_model.dart';
import 'package:gcitest/model/task_model.dart';

class DatabaseHelper {
  final String tableUser = "tbuser";
  final String columnId = "id";
  final String columnName = "name";
  final String columnEmail = "email";
  final String columnPassword = "password";

  final String tableTask = "task";
  final String columnTaskId = "id";
  final String columnUserId = "userId";
  final String columnTask = "task";

  Database? db;

  Future<Database?> checkDatabase() async {
    if (db != null) {
      return db;
    }
    db = await initDb();
    return db;
  }

  initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "gci.db");
    var db = await openDatabase(path, version: 1, onCreate: onCreate);
    return db;
  }

  void onCreate(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE $tableUser (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName TEXT,
        $columnEmail TEXT UNIQUE,
        $columnPassword TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableTask (
        $columnTaskId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnUserId INTEGER,
        $columnTask TEXT,
        FOREIGN KEY ($columnUserId) REFERENCES $tableUser($columnId)
      )
    ''');
  }

 
  Future<int?> saveUser(User user) async {
    var dbClient = await checkDatabase();
    var result = await dbClient!.insert(tableUser, user.toMap());
    print("insert data $result");
    return result;
  }

  Future<int?> saveTask(Task task) async {
    var dbClient = await checkDatabase();
    var result = await dbClient!.insert(tableTask, task.toMap());
    print("Insert task result: $result");
    return result;
  }

  Future<List<Map<String, dynamic>>?> getAllUsers() async {
    var dbClient = await checkDatabase();
    var result = await dbClient!.query(tableUser, columns: [
      columnId,
      columnName,
      columnEmail,
      columnPassword,
    ]);
    return result;
  }

  Future<List<Task>> getTasksByUserId(int userId) async {
    var dbClient = await checkDatabase();
    var result = await dbClient!.query(tableTask,
        where: "$columnUserId = ?", whereArgs: [userId]);
    return result.map((taskMap) => Task.fromMap(taskMap)).toList();
  }

  Future<int?> updateUser(User user) async {
    var dbClient = await checkDatabase();
    var result = await dbClient!.update(tableUser, user.toMap(),
        where: "$columnId = ?", whereArgs: [user.id]);
    return result;
  }

  Future<int?> updateTask(Task task) async {
    var dbClient = await checkDatabase();
    var result = await dbClient!.update(tableTask, task.toMap(),
        where: "$columnTaskId = ?", whereArgs: [task.id]);
    return result;
  }

  Future<int?> deleteUser(int id) async {
    return await db!.delete(tableUser, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int?> deleteTask(int id) async {
    var dbClient = await checkDatabase();
    return await dbClient!.delete(tableTask, where: "$columnTaskId = ?", whereArgs: [id]);
  }

  Future<User?> loginUser(String email, String password) async {
    var dbClient = await checkDatabase();
    List<Map<String, dynamic>>? result = await dbClient!.query(tableUser,
        where: "$columnEmail = ? AND $columnPassword = ?",
        whereArgs: [email, password]);

    if (result != null && result.isNotEmpty) {
      return User.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<int?> registerUser(User user) async {
    var dbClient = await checkDatabase();
    var result = await dbClient!.insert(tableUser, user.toMap());
    return result;
  }
}
