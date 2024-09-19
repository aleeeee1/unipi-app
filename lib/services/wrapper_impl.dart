import 'package:get/get.dart';
import 'package:unipi_orario/entities/lesson.dart';
import 'package:unipi_orario/helper/object_box.dart';
import 'package:unipi_orario/objectbox.g.dart';
import 'package:unipi_orario/services/internal_api.dart';
import 'package:unipi_orario_wrapper/unipi_orario_wrapper.dart' as w;

final wrapper = w.WrapperService();

InternalAPI internalAPI = Get.find<InternalAPI>();
ObjectBox objectBox = Get.find<ObjectBox>();

Future<List<Lesson>> getLessonsFromCache({
  required DateTime date,
  bool forceRefresh = false,
  int maxRetries = 3,
}) async {
  DateTime exactDate = DateTime(date.year, date.month, date.day);
  var box = objectBox.lessonBox;

  var cache = await box
      .query(
        Lesson_.startDateTime.betweenDate(
          exactDate,
          exactDate.add(
            const Duration(days: 1),
          ),
        ),
      )
      .build()
      .findAsync();

  if ((cache.isEmpty || forceRefresh) && maxRetries > 0 && date.weekday != DateTime.saturday && date.weekday != DateTime.sunday) {
    await cacheLessons();
    return await getLessonsFromCache(date: date, maxRetries: maxRetries - 1);
  }

  return cache;
}

Future<void> cacheLessons() async {
  List<Lesson> lessons = await getLessons();

  var box = objectBox.lessonBox;
  await box.putManyAsync(lessons);
}

Future<List<Lesson>> getLessons({bool forceRefresh = false}) async {
  var lessons = await wrapper.fetchLessons(
    calendarId: internalAPI.calendarId,
    startDate: DateTime(2024, 9, 16),
    endDate: DateTime(2025, 7, 1),
  );

  List<Lesson> lessonsObjs = [for (var lesson in lessons) Lesson.fromJson(lesson)];
  return lessonsObjs;
}
