import 'package:flutter/foundation.dart';
import 'package:soochi_patra/models/task.dart';
import 'dart:collection';
import 'package:localstorage/localstorage.dart';

final LocalStorage localStorage = LocalStorage('toDoList.json');

class TaskData extends ChangeNotifier {
  List<Task> _tasks = //private data
      [
    //Task(name: "Complete the on-going flutter app"),
    //isDone : false (by-deafult)
  ];

  //An unmodifiable [List] view of the above List.
  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  void updateTask(Task task) async {
    task.toggleisDone();
    await _saveToStorage();
    notifyListeners();
  }

  void addTask(String newTaskTitle) async {
    _tasks.add(Task(name: newTaskTitle));
    await _saveToStorage();
    notifyListeners(); //re-build all the places which listens to provider object
  }

  void deleteTask(Task task) async {
    _tasks.remove(task);
    await _saveToStorage();
    notifyListeners();
  }

  void clearAllTasks(Task task) async {
    _tasks.clear();
    await _saveToStorage();
    notifyListeners();
  }

  Future<void> _saveToStorage() async {
    //converting class format to JSON format data (saving)
    await localStorage.setItem(
      'todos',
      _tasks.map((Task e) => e.toJSONEncodable()).toList(),
    );
  }

  Future<void> init(tasksList) async {
    //print(tasksList);
    //converting JSON format to class format data (retrieving)
    if (tasksList != null && tasksList.length > 0) {
      _tasks.clear();
      for (Map task in tasksList) {
        _tasks.add(Task(name: task['name'], isDone: task['isDone']));
      }
    }
    await _saveToStorage();
    notifyListeners();
  }
}
