import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/failure/failure.dart';
import 'package:student_management_starter/features/course/data/data_source/local/course_local_data_source.dart';
import 'package:student_management_starter/features/course/domain/entity/course_entity.dart';
import 'package:student_management_starter/features/course/domain/repository/i_course_repository.dart';

final courseLocalRepoProvider = Provider<ICourseRepository>((ref) {
  return CourseLocalRepositoryImpl(
      courseLocalDataSource: ref.read(courseLocalSourceProvider));
});

class CourseLocalRepositoryImpl implements ICourseRepository {
  final CourseLocalSource courseLocalDataSource;

  CourseLocalRepositoryImpl({required this.courseLocalDataSource});

  @override
  Future<Either<Failure, bool>> addCourse(CourseEntity course) {
    return courseLocalDataSource.addCourse(course);
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getAllCourses() {
    return courseLocalDataSource.getAllCourses();
  }

  @override
  Future<Either<Failure, bool>> deleteCourse(CourseEntity course) {
    return courseLocalDataSource.deleteCourse(course);
  }
}
