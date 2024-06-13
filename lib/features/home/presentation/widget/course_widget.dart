import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:student_management_starter/features/course/domain/entity/course_entity.dart';

class CourseWidget extends StatelessWidget {
  final List<CourseEntity> courseList;
  const CourseWidget(
      {super.key, required this.courseList, required WidgetRef ref});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: courseList.length,
      // physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (context, index) {
        return Card(
          color: Colors.blue,
          child: Center(
            child: Text(
              courseList[index].courseName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
