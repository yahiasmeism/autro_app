import 'package:autro_app/core/constants/hive_types.dart';
import 'package:autro_app/core/utils/logger_util.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/authentication/data/models/user_model.dart';
import '../constants/enums.dart';
import '../extensions/hive_box_type_extension.dart';

class HiveBoxManager {
  /// Initialize hive, check adapters and open all boxes.
  static Future init() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);

    initAdapters();

    await openAll();
  }

  static void initAdapters() {
    if (!Hive.isAdapterRegistered(HiveTypes.user)) {
      Hive.registerAdapter(UserModelAdapter());
    }

    if (!Hive.isAdapterRegistered(HiveTypes.userRoles)) {
      Hive.registerAdapter(UserRoleAdapter());
    }
  }

  static Future openAll() async {
    try {
      for (HiveBoxType type in HiveBoxType.values) {
        await Hive.openBox(type.boxName);
      }
    } catch (e) {
      LoggerUtils.e(e.toString());
    }
  }

  static Future<void> closeAll<T>() async {
    return await Hive.close();
  }

  static Future<void> clearAll<T>() async {
    for (HiveBoxType type in HiveBoxType.values) {
      await Hive.box(type.boxName).clear();
    }
  }
}
