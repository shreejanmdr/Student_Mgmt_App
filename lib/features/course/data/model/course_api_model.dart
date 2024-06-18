import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_management_starter/features/course/domain/entity/course_entity.dart';

final courseApiModelProvider = Provider((ref) => const CourseApiModel.empty());

@JsonSerializable()
class CourseApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String courseId;
  final String courseName;

  const CourseApiModel({
    required this.courseId,
    required this.courseName,
  });

  const CourseApiModel.empty()
      : courseId = '',
        courseName = '';

  // From Json(),
  factory CourseApiModel.fromJson(Map<String, dynamic> json) {
    return CourseApiModel(
        courseId: json['_id'], courseName: json['courseName']);
  }

  // To Json(),
  Map<String, dynamic> toJson() {
    return {'courseName': courseName};
  }

  // Convert hive model to entity
  CourseEntity toEntity() => CourseEntity(
        courseName: courseName,
        courseId: courseId,
      );

  // Convert Entity to hive model
  CourseApiModel fromEntity(CourseEntity entity) => CourseApiModel(
        courseName: entity.courseName,
        courseId: entity.courseId ?? '',
      );

  // Convert Hive List to Entity list
  List<CourseEntity> toEntityList(List<CourseApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  List<CourseApiModel> fromEntityList(List<CourseEntity> entities) {
    return entities.map((entity) => fromEntity(entity)).toList();
  }



  @override
  List<Object?> get props => [
        courseId,
        courseName,
      ];
}
