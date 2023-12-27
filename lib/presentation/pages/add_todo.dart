import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_care/presentation/providers/user_data_provider.dart';

class BMIData {
  final TextEditingController berat = TextEditingController();
  final TextEditingController tinggi = TextEditingController();
}

final bmiDataProvider = Provider((ref) => BMIData());

class TodoAddPage extends ConsumerWidget {
  const TodoAddPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(userDataProvider, (previous, next) {
      Navigator.of(context).pop();
    });
    final bmiData = ref.read(bmiDataProvider);
    final email = ref.watch(userDataProvider).value?.email;
    final password = ref.watch(userDataProvider).value?.password;
    return WillPopScope(
      onWillPop: () async {
        bmiData.berat.clear();
        bmiData.tinggi.clear();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              "Add New Task",
              style: GoogleFonts.inter(fontWeight: FontWeight.w500),
            ),
            flexibleSpace: Container(
                decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF16697A),
                  Color(0xFF82C0CC)
                ], // Ganti warna sesuai keinginan
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ))),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Task Name',
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red)),
                        prefixIcon: const Icon(Icons.task_alt_outlined),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 0)),
                    controller: bmiData.berat,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Task is not valid';
                      }
                      return null;
                    },
                  ),
                  TextField(
                    maxLines: null,
                    decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red)),
                        prefixIcon: const Icon(Icons.description_outlined),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 0)),
                    controller: bmiData.tinggi,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Due Date',
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red)),
                        prefixIcon: const Icon(Icons.date_range_outlined),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 0)),
                    controller: bmiData.berat,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Due Date is not valid';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Type',
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red)),
                        prefixIcon: const Icon(Icons.task_alt_outlined),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 0)),
                    controller: bmiData.berat,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Type is not valid';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Time',
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red)),
                        prefixIcon: const Icon(Icons.timer_outlined),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 0)),
                    controller: bmiData.berat,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Time is not valid';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        int beratControl = int.parse(bmiData.berat.text);
                        int tinggiControl = int.parse(bmiData.tinggi.text);

                        if (beratControl != 0 && tinggiControl != 0) {
                          await ref.watch(userDataProvider.notifier).updateBMI(
                              email!, password!, beratControl, tinggiControl);
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Input Error'),
                                  content:
                                      const Text('Please input all values!.'),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Ok"))
                                  ],
                                );
                              });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: const Color(0xFF16687E),
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        textStyle: GoogleFonts.roboto(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      child: const Text("Add"),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
