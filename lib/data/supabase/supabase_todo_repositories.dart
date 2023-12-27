import 'package:self_care/data/repositories/todo_repository.dart';
import 'package:self_care/domain/entities/todo.dart';
import 'package:supabase/supabase.dart';

class SupabaseTodoRepository implements TodoRepository {
  final SupabaseClient supabase;

  SupabaseTodoRepository(this.supabase);

  @override
  Future<List<ToDo>> getTodos() async {
    final response = await supabase.from('list').select('*');
    List<ToDo> result = <ToDo>[];

    for (var todoData in response) {
      result.add(
        ToDo(
          id: todoData['id'],
          taskName: todoData['task_name'],
          description: todoData['description'],
          dueDate: todoData['due_date'],
          type: todoData['type'],
          time: todoData['time'],
          isCompleted: todoData['is_completed'],
        ),
      );
    }

    return result;
  }
}
