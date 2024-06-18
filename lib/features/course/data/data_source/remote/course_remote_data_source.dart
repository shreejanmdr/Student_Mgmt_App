import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/app/constants/api_endpoint.dart';
import 'package:student_management_starter/core/failure/failure.dart';
import 'package:student_management_starter/core/networking/remote/http_service.dart';
import 'package:student_management_starter/core/shared_prefs/user_shared_prefs.dart';
import 'package:student_management_starter/features/course/data/dto/get_all_courses_dto.dart';
import 'package:student_management_starter/features/course/data/model/course_api_model.dart';
import 'package:student_management_starter/features/course/domain/entity/course_entity.dart';

final courseRemoteDataSourceProvider = Provider(
  (ref) => CourseRemoteDataSource(
      dio: ref.read(httpServiceProvider),
      courseApiModel: ref.read(courseApiModelProvider),
      userSharedPrefs: ref.read(userSharedPrefsProvider)),
);

class CourseRemoteDataSource {
  final Dio dio;
  final CourseApiModel courseApiModel;
  final UserSharedPrefs userSharedPrefs;

  CourseRemoteDataSource({
    required this.dio,
    required this.courseApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, bool>> addCourse(CourseEntity course) async {
    try {
      var response = await dio.post(
        ApiEndpoints.createCourse,
        data: courseApiModel.fromEntity(course).toJson(),
      );

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, List<CourseEntity>>> getAllCourses() async {
    try {
      var response = await dio.get(ApiEndpoints.getAllCourse);
      if (response.statusCode == 200) {
        // 1st way
        // return Right(
        //   (response.data['data'] as List)
        //       .map((batch) => BatchApiModel.fromJson(batch).toEntity())
        //       .toList(),
        // );
        // OR
        // 2nd way
        GetAllCoursesDTO courseAddDTO =
            GetAllCoursesDTO.fromJson(response.data);
        return Right(courseApiModel.toEntityList(courseAddDTO.data));
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> deleteCourse(String courseId) async {
    try {
      // Retrieve token from shared preferences
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );
      //localhost:3000/api/v1/course/666fa63c025b203550d06179
      Response response = await dio.delete(
        ApiEndpoints.deleteCourse + courseId,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
