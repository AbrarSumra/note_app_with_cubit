import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wscube_cubit/Constant/text_field.dart';
import 'package:wscube_cubit/ListCubit/list_cubit.dart';

class SecondPage extends StatelessWidget {
  SecondPage({
    super.key,
    this.isUpdate = false,
    this.noteIndex = 0,
    this.noteTitle = "",
    this.noteDesc = "",
  });

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  final bool isUpdate;
  final int noteIndex;
  final String noteTitle;
  final String noteDesc;

  @override
  Widget build(BuildContext context) {
    titleController.text = noteTitle;
    descController.text = noteDesc;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Page"),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(height: 21),
            CstmTextField(
              hintText: "Title",
              controller: titleController,
            ),
            const SizedBox(height: 21),
            CstmTextField(
              hintText: "Description",
              controller: descController,
            ),
            const SizedBox(height: 11),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty &&
                        descController.text.isNotEmpty) {
                      var mNote = {
                        "title": titleController.text,
                        "desc": descController.text.toString(),
                      };

                      if (isUpdate) {
                        /// Update Note
                        BlocProvider.of<ListCubit>(context)
                            .updateNote(mNote, noteIndex);
                      } else {
                        /// Add Note
                        BlocProvider.of<ListCubit>(context).addNote(mNote);
                      }
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    isUpdate ? "Update" : "Add",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
