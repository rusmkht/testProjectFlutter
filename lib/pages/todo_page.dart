import 'package:flutter/material.dart';
import 'package:flutter_project_1/data/tasks.dart';

class Todo_page extends StatefulWidget {
  @override
  _Todo_pageState createState() => _Todo_pageState();
}

class _Todo_pageState extends State<Todo_page> {
  var colorBack = const Color(0xff01062B);
  var colorMain = const Color(0xff29046E);

  late Future<TaskList> taskList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskList = getTasksList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBack,
      appBar: AppBar(
        title: Text(
          "ToDo List",
          style: TextStyle(fontFamily: 'RaleWay', fontSize: 23),
        ),
        centerTitle: true,
        backgroundColor: colorMain,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: FutureBuilder<TaskList>(
          future: taskList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  addAutomaticKeepAlives: false,
                  itemCount: snapshot.data!.tasks.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      selected: snapshot.data!.tasks[index].completed,
                      activeColor: Colors.indigo,
                      checkColor: colorBack,
                      controlAffinity: ListTileControlAffinity.leading,
                      value: snapshot.data!.tasks[index].completed,
                      onChanged: (value) {
                        setState(() {
                          snapshot.data!.tasks[index].completed = value!;
                        });
                      },
                      title: Text(
                        "${snapshot.data!.tasks[index].title}",
                        style: TextStyle(fontSize: 17),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              print("${snapshot.error}");
              return Text("Error: ${snapshot.error}");
            } else {
              return Center(
                child: Text(
                  "Loading...",
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
