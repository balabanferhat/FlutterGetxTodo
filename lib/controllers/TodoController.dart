import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_todo/models/Todo.dart';

class TodoController extends GetxController {
  var todos = [].obs;

  @override
  void onInit() {
    List? storedTodos = GetStorage().read<List>('todos');

    if (storedTodos != null) {
      todos.value = storedTodos.map((e) => Todo.fromJson(e)).toList();
    }

    /*ever(todos, (_) {
      //// with the ever worker, whenever the variable changes, function is called
      GetStorage().write('todos', todos.toList());
    });*/
    super.onInit();
  }

  updateToStorage() {
    GetStorage().write('todos', todos.toList());
  }
}
