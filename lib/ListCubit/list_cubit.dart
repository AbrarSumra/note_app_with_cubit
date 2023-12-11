import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wscube_cubit/ListCubit/list_state.dart';

class ListCubit extends Cubit<ListState> {
  ListCubit() : super(ListState(mData: []));

  /// Add Note
  void addNote(Map<String, dynamic> newNote) {
    emit(ListState(mData: state.mData, isLoading: true));
    Timer(const Duration(seconds: 2), () {
      var random = Random().nextInt(100);
      if (random % 5 == 0) {
        emit(ListState(
            mData: state.mData,
            isLoading: false,
            isError: true,
            errorMsg: "Data not added"));
      } else {
        var currData = state.mData;
        currData.add(newNote);
        emit(ListState(mData: currData, isLoading: false, isError: false));
      }
    });
  }

  /// Update Note
  void updateNote(Map<String, dynamic> updateNote, int index) {
    var currData = state.mData;
    currData[index] = updateNote;

    emit(ListState(mData: currData));
  }

  /// Delete Note
  void deleteNote(int index) {
    var currData = state.mData;
    currData.removeAt(index);

    emit(ListState(mData: currData));
  }
}
