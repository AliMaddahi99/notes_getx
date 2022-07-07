import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'notes_app.dart';

void main() {
  GetStorage.init();
  runApp(const NotesApp());
}
