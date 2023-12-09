import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wscube_cubit/ListCubit/list_state.dart';

class ListCubit extends Cubit<ListState> {
  ListCubit() : super(ListState(mData: []));

  /// Add Note
  void addNote(Map<String, dynamic> newNote) {
    var currData = state.mData;
    currData.add(newNote);
    emit(ListState(mData: currData));
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
