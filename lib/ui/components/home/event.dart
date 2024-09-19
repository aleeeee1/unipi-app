import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unipi_orario/entities/lesson.dart';

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
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 2),
      color: Theme.of(context).colorScheme.onSecondaryFixed,
      child: ListTile(
        title: Text(widget.lesson.name),
        subtitle: Text(
          '${DateFormat('HH:mm').format(widget.lesson.startDateTime)} - ${DateFormat('HH:mm').format(widget.lesson.endDateTime)}',
        ),
        leading: CircleAvatar(
          child: Text(
            widget.lesson.courseName.replaceAll("CORSO ", ""),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
