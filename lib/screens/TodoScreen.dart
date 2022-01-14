import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:getx_todo/controllers/TodoController.dart';
import 'package:getx_todo/models/Todo.dart';

class TodoScreen extends StatelessWidget {
  final TodoController todoController = Get.find();
  final int? index;

  TodoScreen({this.index});

  @override
  Widget build(BuildContext context) {
    print("---index:" + index.toString());
    String title = '';
    String text = '';
    if (index != null) {
      title = todoController.todos[index!].title;
      text = todoController.todos[index!].text;
    }
    TextEditingController textEditingController =
        TextEditingController(text: text);

    TextEditingController titleEditingController =
        TextEditingController(text: title);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(12.0),
        margin: EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            TextField(
              controller: titleEditingController,
              autofocus: true,
              decoration: const InputDecoration(
                  hintText: 'Write your task title here...',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none),
              style: const TextStyle(
                fontSize: 25.0,
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 1,
            ),
            const Divider(
              color: Colors.black,
              height: 1,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            Expanded(
              child: TextField(
                controller: textEditingController,
                autofocus: false,
                decoration: const InputDecoration(
                    hintText: 'Write details about your task here ...',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none),
                style: const TextStyle(
                  fontSize: 16.0,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 999,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  child: Text('Cancel'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Get.back();
                  },
                ),
                ElevatedButton(
                  child: Text((index == null) ? 'Add' : 'Save'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    if (index == null) {
                      todoController.todos.add(Todo(
                          title: titleEditingController.text,
                          text: textEditingController.text));
                    } else {
                      var editing = todoController.todos[index!];
                      editing.text = textEditingController.text;
                      editing.title = titleEditingController.text;
                      todoController.todos[index!] = editing;
                    }

                    todoController.updateToStorage();

                    Get.back();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
