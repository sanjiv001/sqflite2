// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:sqflite2/model/model.dart';
import 'package:sqflite2/service/sql_service.dart';
import 'package:sqflite2/widget/text_form_field.dart';

class UpdateTaskScreen extends StatefulWidget {
  late ToDoModel? toDoModel;
  int? id;
  UpdateTaskScreen({
    super.key,
    this.id,
    this.toDoModel,
  });

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  final titleController = TextEditingController();
  final taskdetailcontroller = TextEditingController();
  final idController = TextEditingController();

  void initState() {
    super.initState();
    // Initialize toDoModel in initState
    // toDoModel = ToDoModel(); // Initialize it with appropriate values
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(" Update Task"),
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
                      String id = idController.text.trim();
                      String title = titleController.text.trim();
                      String detail = taskdetailcontroller.text.trim();

                      setState(() {
                        idController.text = '';
                        titleController.text = '';
                        idController.text = '';
                        DateTime.now();

                        print("Update");
                      });
                    },
                    child: const Text(
                      "UpDate",
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

  Future<dynamic> updateData(ToDoModel toDoModel) async {
    final todomodel = ToDoModel(
      title: toDoModel.title,
      date: toDoModel.date,
      detail: toDoModel.detail,
      id: toDoModel.id,
    );
    await DatabaseService.updateToDoList(
      todomodel: todomodel,
    );
  }
}
