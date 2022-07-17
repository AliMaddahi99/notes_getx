import 'package:flutter/material.dart';
import 'package:notes_getx/tasks/widgets/add_task_text_field.dart';
import 'package:notes_getx/tasks/widgets/dismissible_card_listview.dart';

class TaskApp extends StatelessWidget {
  const TaskApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Todo Getx",
        ),
      ),
      body: Column(
        children: [
          DismissibleCardListView(),
          AddTaskTextField(),
        ],
      ),
    );
  }
}
