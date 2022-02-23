import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;

class TaskList {
  List<Task> tasks;

  TaskList(this.tasks);

  factory TaskList.fromJson(List<dynamic> json) {
    var tasksJson = json as List;

    List<Task> tasksList = tasksJson.map((e) => Task.fromJson(e)).toList();

    return TaskList(tasksList);
  }
}

class Task {
  final id;
  final title;
  bool completed;

  Task({this.id, this.title, required this.completed});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id'] as int,
        title: json['title'] as String,
        completed: json['completed'] as bool);
  }
}

Future<TaskList> getTasksList() async {
  const url = 'https://jsonplaceholder.typicode.com/todos';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print("OK");
    return TaskList.fromJson(json.decode(response.body));
  } else {
    print("Not OK");
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
