
import 'package:flutter/material.dart';
import 'package:travel_app/domain/taskModel/taskModel.dart';


class TaskDesc extends StatelessWidget {
  final TaskModel task;

  const TaskDesc({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${task.title}",
          textAlign: TextAlign.start,
          style: const TextStyle(
              fontSize: 22,
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          child: Text(
            task.content,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 16,
                height: 1.2,
                color: const Color.fromARGB(255, 231, 231, 231),
                fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
