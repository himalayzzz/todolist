import 'package:flutter/material.dart';
import 'package:todo_project/model/taskmodel.dart';

class TaskDetail extends StatelessWidget {
  final TaskModel task;

  const TaskDetail({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
        backgroundColor: Color.fromARGB(255, 230, 103, 145),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Task ID: ${task.taskid}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                Text(
                  'Task Name: ${task.taskname}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 12),
                Text(
                  'Status: ${task.status == '0' ? 'Not Completed' : 'Completed'}',
                  style: TextStyle(
                    fontSize: 16,
                    color: task.status == '0' ? Colors.red : Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
