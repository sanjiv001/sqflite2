import 'package:flutter/material.dart';
import 'package:sqflite2/screen/add_screen.dart';
import 'package:sqflite2/screen/update_screen.dart';
import 'package:sqflite2/service/sql_service.dart';

import '../model/model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DatabaseService databaseService;
  late Future<List<ToDoModel>> toDoList;
  late final ToDoModel toDoModel;

  final titleController = TextEditingController();
  final taskdetailcontroller = TextEditingController();
  final idController = TextEditingController();
  int? id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      databaseService = DatabaseService();
      loadData();
    });
  }

  loadData() {
    toDoList = DatabaseService.getToDoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: const Text("ToDoApp"),
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 80,
            right: 34,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddTaskScreen(),
                  ),
                );
              },
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<ToDoModel>>(
        future: DatabaseService.getToDoList(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ToDoModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      // trailing: Text(DateFormat(DateFormat.ABBR_MONTH)
                      //     .format(todomodel.date)),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateTaskScreen(
                                      id: toDoModel.id,
                                      toDoModel: ToDoModel(
                                        id: snapshot.data![index].id,
                                        title: snapshot.data![index].title,
                                        date: snapshot.data![index].date,
                                        detail: snapshot.data![index].detail,
                                      ),
                                      //  updateData( toDoModel : ToDoModel(title: snapshot.data![index].id,
                                      //   date: date, detail: detail));

                                      // id: snapshot.data![index].id,
                                      // id: toDoModel.id,
                                      // toDoModel: ToDoModel(
                                      //    id: snapshot.data![index].id,
                                      //   title: snapshot.data![index].title,
                                      //   date: snapshot.data![index].date,
                                      //   detail: snapshot.data![index].detail,
                                      // ),
                                    ),
                                  ),
                                );
                                // updateData(snapshot.data![index]);

                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => const HomeScreen()),
                                // );
                                setState(() {});
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  deleteData(snapshot.data![index]);
                                });
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                      title: Text(
                        snapshot.data![index].title.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ), //
                      ),
                      subtitle: Text(
                        snapshot.data![index].detail.toString(),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: Text(" No Data Available"),
          );
        },
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

  Future<dynamic> deleteData(ToDoModel toDoModel) async {
    final todomodel = ToDoModel(
      title: toDoModel.title,
      date: toDoModel.date,
      detail: toDoModel.detail,
      id: toDoModel.id,
    );
    DatabaseService.deleteToDoList(
      todomodel: todomodel,
    );
  }
}
