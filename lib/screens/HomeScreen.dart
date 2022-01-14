import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:getx_todo/controllers/TodoController.dart';
import 'package:getx_todo/screens/TodoScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.put(TodoController());
    return Scaffold(
        appBar: AppBar(
          title: Text('My Todo\'s'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Get.to(() => TodoScreen());
          },
        ),
        body: Container(
          child: Obx(() => ListView.separated(
              itemBuilder: (context, index) => Dismissible(
                    key: UniqueKey(),
                    onDismissed: (_) {
                      var removed = todoController.todos[index];
                      todoController.todos.removeAt(index);
                      todoController.updateToStorage();
                      Get.snackbar(
                        'Task removed',
                        'The task "${removed.title}" was successfully removed.',
                        snackPosition: SnackPosition.TOP,
                      );
                    },
                    child: ListTile(
                      title: Text(todoController.todos[index].title,
                          style: (todoController.todos[index].done)
                              ? const TextStyle(
                                  color: Colors.red,
                                  decoration: TextDecoration.lineThrough)
                              : TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color)),
                      onTap: () {
                        Get.to(() => TodoScreen(
                              index: index,
                            ));
                      },
                      leading: Checkbox(
                        value: todoController.todos[index].done,
                        onChanged: (v) {
                          var changed = todoController.todos[index];
                          changed.done = v;
                          todoController.todos[index] = changed;
                          todoController.updateToStorage();
                        },
                      ),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ),
              separatorBuilder: (_, __) => Divider(),
              itemCount: todoController.todos.length)),
        ));
  }
}
