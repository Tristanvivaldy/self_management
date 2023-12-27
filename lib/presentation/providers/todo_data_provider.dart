import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:self_care/domain/entities/todo.dart';
import 'package:self_care/domain/usecase/todo.dart';
import 'package:self_care/presentation/providers/todo_provider.dart';

part 'todo_data_provider.g.dart';

@Riverpod(keepAlive: true)
class TodoData extends _$TodoData {
  @override
  Future<List<ToDo>?> build() async {
    final hasil = await getList();
    print(hasil);
    return hasil;
  }

  Future<List<ToDo>?> getList() async {
    state = const AsyncLoading();

    Todos todos = ref.read(todosProvider);
    var hasil = await todos();
    state = AsyncData(hasil);
    return hasil;
  }
}
