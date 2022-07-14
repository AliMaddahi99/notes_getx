import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notes_getx/models/note_model.dart';

class NoteController extends GetxController {
  var notes = <NoteModel>[].obs;
  var isGridView = false.obs;
  var selectedNote = [].obs;
  var isSelectMode = false.obs;

  void deleteNote(int id) {
    notes.removeWhere((note) => note.id == id);
  }

  void selectNote(int id) {
    selectedNote.contains(id) ? selectedNote.remove(id) : selectedNote.add(id);
  }

  String getSelectedNotesCount() {
    return selectedNote.length == 1
        ? "${selectedNote.length} item"
        : "${selectedNote.length} items";
  }

  @override
  void onInit() {
    // Save and read notes
    var storedNotes = GetStorage().read<List>("notes");
    if (storedNotes != null) {
      notes = storedNotes.map((e) => NoteModel.fromJson(e)).toList().obs;
    }
    ever(notes, (_) {
      GetStorage().write("notes", notes.toList());
    });

    // Save and read Layout mode, Gridview/Listview
    var layoutIsGridView = GetStorage().read("layout");
    if (layoutIsGridView != null) {
      isGridView.value = layoutIsGridView;
    }
    ever(isGridView, (_) {
      GetStorage().write("layout", isGridView.value);
    });

    super.onInit();
  }
}
