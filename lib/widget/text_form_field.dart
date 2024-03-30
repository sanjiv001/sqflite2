import 'package:flutter/material.dart';

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
