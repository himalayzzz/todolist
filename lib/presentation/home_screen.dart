import 'package:flutter/material.dart';
import 'package:todo_project/model/taskmodel.dart';
import 'package:todo_project/presentation/splash_screen.dart';
import 'package:todo_project/presentation/taskdetail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<TaskModel> todoItem = [];
int todoCounter = 0;
TextEditingController todotext = TextEditingController();
int editflag = 0;
int? editIndex;

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SplashScreen()),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: const Color.fromARGB(255, 230, 103, 145),
        title: Text(
          'To do list',
          style: TextStyle(
            color: const Color.fromARGB(255, 236, 221, 84),
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              SizedBox(
                height: 100,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: todotext,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Task cannot be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter a task',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.pink.shade50,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (editflag == 0) {
                                todoCounter++;
                                TaskModel t = TaskModel(
                                  taskid: todoCounter.toString(),
                                  status: '0',
                                  taskname: todotext.text,
                                );
                                setState(() {
                                  addTodo(t);
                                  todotext.clear();
                                });
                              } else {
                                TaskModel updated = TaskModel(
                                  taskid: todoItem[editIndex!].taskid,
                                  status: todoItem[editIndex!].status,
                                  taskname: todotext.text,
                                );
                                setState(() {
                                  editTodo(editIndex!, updated);
                                  editflag = 0;
                                  editIndex = null;
                                  todotext.clear();
                                });
                              }
                            }
                          },
                          icon: Icon(
                            (editflag == 0)
                                ? Icons.add_circle_outline
                                : Icons.save,
                            color: Colors.pink,
                          ),
                        ),
                        Visibility(
                          visible: editflag == 1,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                editflag = 0;
                                editIndex = null;
                                todotext.clear();
                              });
                            },
                            icon: Icon(Icons.cancel, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text('${index + 1}'),
                      title: InkWell(
                        onTap: () {
                          setState(() {
                            todoItem[index].status =
                                todoItem[index].status == '0' ? '1' : '0';
                          });
                        },
                        child: Text(
                          todoItem[index].taskname,
                          style: TextStyle(
                            color: todoItem[index].status == '1'
                                ? Colors.green
                                : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            todoItem[index].status == '0'
                                ? 'Not Completed'
                                : 'Completed',
                            style: TextStyle(
                              color: todoItem[index].status == '0'
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                todoItem.removeAt(index);
                              });
                            },
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                editflag = 1;
                                editIndex = index;
                                todotext.text = todoItem[index].taskname;
                              });
                            },
                            icon: Icon(Icons.edit, color: Colors.blue),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TaskDetail(
                                    task: todoItem[index],
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.info_outline, color: Colors.orange),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: todoItem.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addTodo(TaskModel t) {
    todoItem.add(t);
  }

  void editTodo(int index, TaskModel t) {
    todoItem[index] = t;
  }
}
