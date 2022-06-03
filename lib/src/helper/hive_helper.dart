import 'dart:io';

import 'package:hive/hive.dart';
import 'package:memories/src/model/memory.dart';
import 'package:path_provider/path_provider.dart';

class HiveHelper {
  late Box<Memory> memoriesBox;
  Future initialize() async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocDirectory.path);

    Hive.registerAdapter(MemoryAdapter());

    memoriesBox = await Hive.openBox<Memory>("memories");
  }

  Future<bool> add(Memory memory) async {
    await memoriesBox.add(memory);
    return true;
  }

  Future<bool> remove(Memory memory) async {
    for (var m in memoriesBox.values) {
      if (memory.url == m.url) {
        memoriesBox.delete(m.key);
        return true;
      }
    }

    return false;
  }
}
