import 'package:flutter/material.dart';
import 'package:sqflite2/model/model.dart';
import 'package:sqflite2/screen/add_screen.dart';
import 'package:sqflite2/service/sql_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DatabaseService databaseService;
  late Future<List<ToDoModel>> toDoList;
  late final ToDoModel toDoModel;

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
                    //     child: Column(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     Text(
                    //       snapshot.data![index].title.toString(),
                    //     ),
                    //     Text(
                    //       snapshot.data![index].title.toString(),
                    //     ),
                    //     Text(
                    //       snapshot.data![index].title.toString(),
                    //     ),
                    //     Text(
                    //       snapshot.data![index].title.toString(),
                    //     ),
                    //   ],
                    // )
                    child: ListTile(
                      leading: CircleAvatar(
                          child: Text(
                        snapshot.data![index].id.toString(),
                      )),
                      // trailing: Text(DateFormat(DateFormat.ABBR_MONTH)
                      //     .format(todomodel.date)),
                      trailing: SizedBox(
                        child: IconButton(
                          onPressed: () {
                            setState(() {});
                          },
                          icon: Icon(Icons.delete),
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

  // Future<dynamic> updateData() async {
  //   final todomodel = ToDoModel(
  //       title: title.text,
  //       date: widget.toDoModel!.date,
  //       detail: taskdetailcontroller.text);
  //   await DatabaseService.updateToDoList(todomodel: todomodel);
  // }

  // Future<dynamic> deletedata() async {
  //   DatabaseService.deleteToDoList(todomodel: todomodel!).then(
  //     (e) => Navigator.pop(context),
  //   );
  // }
}
