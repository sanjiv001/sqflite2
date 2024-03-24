class ToDoModel {
  int? id;
  String title;
  String detail;
  DateTime date;

  ToDoModel({
    this.id,
    required this.title,
    required this.date,
    required this.detail,
  });

  ToDoModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        date = res['date'],
        detail = res['detail'];

  Map<String, Object?> toMap() {
    return {
      'title': title,
      'date': date.toString(),
      'detail': detail,
    };
  }
}


// class ToDo {
//   int? _id;
//   String? _title;
//   String? _detail;
//   String? _type;
//   String? _date;
//   int? _priority;

//   ToDo(_id, _title,  _type, _date, _priority, [_detail]);
// }

// class ToDo {
//   int? id;
//   String? task;
//   String? detail;
//   String? type;

//   ToDo({
//     id,
//     task,
//     detail,
//     type,
//   });

//   Map<String, Object?> toMap() {
//     return {
//       'id': id,
//       'task': task,
//       'detail': detail,
//       'type': type,
//     };
//   }

//   @override
//   String toString() =>
//       'ToDo{id: $id, detail: $task, detail: $detail, type: $type,}';
// }
