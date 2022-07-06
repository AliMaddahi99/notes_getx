import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/screens/add_note.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes Getx"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Get.to(AddNote()),
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
