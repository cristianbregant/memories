import 'package:memories/src/helper/hive_helper.dart';

class MemoriesUtils {
  static HiveHelper? hiveHelper;

  static bool get isInitialized => hiveHelper != null;

  static Future<void> initialize() async {
    hiveHelper = HiveHelper();
    await hiveHelper!.initialize();
  }
}
