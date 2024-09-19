// https://docs.objectbox.io/getting-started#create-a-store

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:unipi_orario/entities/lesson.dart';
import '../objectbox.g.dart'; // created by `flutter pub run build_runner build`

class ObjectBox {
  /// The Store of this app.
  late final Store store;
  late final Box<Lesson> lessonBox;

  ObjectBox._create(this.store) {
    lessonBox = Box<Lesson>(store);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore(directory: p.join(docsDir.path, "obx-example"));
    return ObjectBox._create(store);
  }
}
