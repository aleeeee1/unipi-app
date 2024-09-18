import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipi_orario/services/internal_api.dart';
import 'package:unipi_orario_wrapper/unipi_orario_wrapper.dart';

final wrapper = WrapperService();
InternalAPI internalAPI = Get.find<InternalAPI>();
List<Lesson>? lessons;

Future<List<Lesson>> getLessons({bool forceRefresh = false}) async {
  if (lessons == null || forceRefresh) {
    debugPrint("Fetched new data");
    lessons = await wrapper.fetchLessons(
      calendarId: internalAPI.calendarId,
      startDate: DateTime(2024, 9, 16),
      endDate: DateTime(2025, 7, 31),
    );
  }

  return lessons!;
}
