import 'package:flutter/material.dart';
import 'package:unipi_orario_wrapper/unipi_orario_wrapper.dart';

class Event extends StatefulWidget {
  final Lesson lesson;
  const Event({
    super.key,
    required this.lesson,
  });

  @override
  State<Event> createState() => EventState();
}

class EventState extends State<Event> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.lesson.courseName),
      subtitle: Text(widget.lesson.name),
    );
  }
}
