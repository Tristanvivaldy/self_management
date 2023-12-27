import 'package:self_care/domain/entities/todo.dart';

abstract interface class TodoRepository {
  Future<List<ToDo>> getTodos();
}
