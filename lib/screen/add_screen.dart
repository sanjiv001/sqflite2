// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:sqflite2/model/model.dart';
import 'package:sqflite2/screen/home_screen.dart';
import 'package:sqflite2/service/sql_service.dart';

class AddTaskScreen extends StatefulWidget {
  final ToDoModel? toDoModel;
  const AddTaskScreen({
    super.key,
    this.toDoModel,
  });

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final titleController = TextEditingController();
  final taskdetailcontroller = TextEditingController();
  final idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Add task"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Container(
            // height: 620,
            // width: 480,
            color: Colors.amber,
            child: Column(children: [
              const SizedBox(
                height: 40,
              ),
              MyTextFormField(
                myhint: "IdNo.",
                mycontroller: idController,
                myMaxLine: 1,
              ),
              MyTextFormField(
                myhint: "Enter  task Title",
                mycontroller: titleController,
                myMaxLine: 1,
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 8,
                  controller: taskdetailcontroller,
                  decoration: InputDecoration(
                    hintText: "Enter Task Detail",
                    hintStyle: const TextStyle(
                        fontSize: 20, color: Color.fromARGB(255, 8, 12, 16)),
                    fillColor: Color.fromARGB(255, 242, 242, 242),
                    filled: true,
                    focusColor: Colors.blue,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                      borderSide: const BorderSide(
                        color: Colors.black12,
                        width: 1,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(31, 185, 106, 106),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 46,
                  width: 160,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        insertData();
                        print("added");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                        );
                      });
                    },
                    child: const Text(
                      "ADD",
                      style: TextStyle(
                          color: Color.fromARGB(255, 12, 12, 12),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Future<dynamic> insertData() async {
    final todomodel = ToDoModel(
        title: titleController.text,
        date: DateTime.now(),
        detail: taskdetailcontroller.text);
    await DatabaseService.insertToDoList(todomodel: todomodel);
  }

  Future<dynamic> updateData() async {
    final todomodel = ToDoModel(
        title: titleController.text,
        date: widget.toDoModel!.date,
        detail: taskdetailcontroller.text);
    await DatabaseService.updateToDoList(todomodel: todomodel);
  }

  // Future<dynamic> deletedata() async {
  //   DatabaseService.deleteToDoList(todomodel: todomodel!).then(
  //     (e) => Navigator.pop(context),
  //   );
  // }
}

class MyTextFormField extends StatelessWidget {
  final TextEditingController mycontroller;
  final String? myhint;
  final int myMaxLine;
  // final TextEditingController taskController;
  const MyTextFormField({
    super.key,
    required this.mycontroller,
    required this.myhint,
    required this.myMaxLine,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        maxLines: myMaxLine,
        controller: mycontroller,
        decoration: InputDecoration(
          hintMaxLines: 1,
          hintText: myhint,
          hintStyle: const TextStyle(
              fontSize: 20, color: Color.fromARGB(255, 8, 12, 16)),
          fillColor: Color.fromARGB(255, 242, 242, 242),
          filled: true,
          focusColor: Colors.blue,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              8,
            ),
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              8,
            ),
            borderSide: const BorderSide(
              color: Colors.black12,
              width: 1,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              8,
            ),
            borderSide: const BorderSide(
              color: Color.fromARGB(31, 161, 33, 33),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
