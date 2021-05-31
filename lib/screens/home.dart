import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todowebapp/helper_functions/helper_functions.dart';
import 'package:todowebapp/services/database.dart';
import 'package:todowebapp/widgets/widget.dart';

String uId = 'Qndy19ba82sdi27bnx';

class Home extends StatefulWidget {
  String userName;
  String userEmail;
  Home({this.userName, this.userEmail});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String date;
  TextEditingController taskEditingController = TextEditingController();
  Stream taskStream;
  DatabaseServices databaseServices = DatabaseServices();

  @override
  void initState() {
    var now = DateTime.now();
    date =
        '${HelperFunctions.getWeek(now.weekday)} ${HelperFunctions.getMonth(now.month)} ${now.day}';
    super.initState();
    databaseServices.getTasks(uId).then((val) {
      taskStream = val;
      setState(() {});
    });
  }

  Widget taskList() {
    return StreamBuilder(
      stream: taskStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.only(top: 16.0),
                itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return TaskTile(
                    snapshot.data.documents[index].data['isCompleted'],
                    snapshot.data.documents[index].data['task'],
                    snapshot.data.documents[index].documentID,
                  );
                },
              )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets().mainAppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Container(
            width: 600,
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 34.0),
            child: Column(
              children: [
                Text(
                  'My Day',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                Text(date),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: taskEditingController,
                        decoration: InputDecoration(hintText: 'Add Task'),
                        onChanged: (value) {
                          //taskEditingController.text = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    taskEditingController.text.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              Map<String, dynamic> taskMap = {
                                'task': taskEditingController.text,
                                'isCompleted': false
                              };
                              taskEditingController.text = '';
                              databaseServices.createTask(uId, taskMap);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 5.0,
                              ),
                              child: Text('ADD'),
                            ),
                          )
                        : Container(),
                  ],
                ),
                taskList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TaskTile extends StatefulWidget {
  final bool isCompleted;
  final String task;
  final String documentId;
  TaskTile(this.isCompleted, this.task, this.documentId);

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Map<String, dynamic> taskMap = {
                'isCompleted': !widget.isCompleted
              };
              DatabaseServices().updateTask(uId, taskMap, widget.documentId);
            },
            child: Container(
              width: 24.0,
              height: 24.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black87,
                ),
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: widget.isCompleted
                  ? Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 14.0,
                    )
                  : Container(),
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            widget.task,
            style: TextStyle(
              color: widget.isCompleted
                  ? Colors.black87.withOpacity(0.7)
                  : Colors.black87,
              fontSize: 17.0,
              decoration: widget.isCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              DatabaseServices().deleteTask(uId, widget.documentId);
            },
            child: Icon(
              Icons.close,
              size: 13.0,
              color: Colors.black87.withOpacity(0.7),
            ),
          )
        ],
      ),
    );
  }
}
