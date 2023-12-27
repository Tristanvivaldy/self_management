import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_care/presentation/pages/add_todo.dart';
import 'package:self_care/presentation/providers/todo_data_provider.dart';

class ToDoListPage extends ConsumerWidget {
  const ToDoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(children: [
        ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [Color(0xFF16697A), Color(0xFF82C0CC)],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              )),
            )),
        WidgetContent(),
      ]),
    );
  }
}

// ignore: must_be_immutable
class WidgetContent extends ConsumerWidget {
  bool isChecked = true;

  WidgetContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "To Do List",
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Flexible(
              child: Consumer(
                builder: (context, ref, child) {
                  return ref.watch(todoDataProvider).when(data: (todos) {
                    return ListView.builder(
                      itemCount: todos?.length ?? 0,
                      itemBuilder: (context, index) {
                        final todo = todos?[index];
                        return Container(
                          margin: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.075,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.02,
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                  color: getColorByType(todo?.type) ??
                                      Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              Checkbox(
                                value: todo?.isCompleted ?? false,
                                activeColor: Colors.green,
                                onChanged: (value) {
                                  // Gantilah dengan logika set isCompleted pada data
                                  // dari penyedia Anda
                                  // ref.read(todoProvider).updateIsCompleted(index, value!);
                                },
                              ),
                              Text(
                                todo?.time ?? '',
                                style: GoogleFonts.inter(color: Colors.grey),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                todo?.taskName ?? '',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }, error: (error, stackTrace) {
                    // Menampilkan pesan error
                    return Text('Error: $error');
                  }, loading: () {
                    // Menampilkan indikator loading
                    return const CircularProgressIndicator();
                  });
                },
              ),
            ),
            SizedBox(
                width: 70,
                height: 70,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TodoAddPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF16687E)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "+",
                            style: GoogleFonts.inter(fontSize: 50),
                          ),
                        )))),
          ],
        ),
      ),
    );
  }
}

Color? getColorByType(String? type) {
  switch (type) {
    case 'Pribadi':
      return Colors.blue;
    case 'Perusahaan':
      return Colors.green;
    case 'Lainnya':
      return Colors.orange;
    default:
      return null;
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.20);
    path.quadraticBezierTo(
      size.width * 0.7,
      size.height * 0.25,
      size.width * 0.75,
      size.height * 0,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
