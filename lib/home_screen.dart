import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wscube_cubit/ListCubit/list_cubit.dart';
import 'package:wscube_cubit/ListCubit/list_state.dart';
import 'package:wscube_cubit/second_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocBuilder<ListCubit, ListState>(
        builder: (context, state) {
          var dataFromCubit = state.mData;

          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.isError) {
            return Center(
              child: Text(
                state.errorMsg,
                style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
            );
          }
          return state.mData.isNotEmpty
              ? ListView.builder(
                  itemCount: dataFromCubit.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(
                          "${dataFromCubit[index]["title"]}",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "${dataFromCubit[index]["desc"]}",
                          style: const TextStyle(fontSize: 15),
                        ),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => SecondPage(
                                                isUpdate: true,
                                                noteIndex: index,
                                                noteTitle:
                                                    "${dataFromCubit[index]["title"]}",
                                                noteDesc:
                                                    "${dataFromCubit[index]["desc"]}",
                                              )));
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        return AlertDialog(
                                          title: const Text("Delete?"),
                                          content: const Text(
                                              "Are you want sure to delete?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                BlocProvider.of<ListCubit>(
                                                        context)
                                                    .deleteNote(index);
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Yes"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("No"),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ));
                  },
                )
              : const Center(
                  child: Text(
                    "No any note added yet...",
                    style: TextStyle(fontSize: 18),
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => SecondPage()));
        },
        child: const Icon(
          Icons.navigate_next,
          size: 50,
        ),
      ),
    );
  }
}
