// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_courses_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllCoursesDTO _$GetAllCoursesDTOFromJson(Map<String, dynamic> json) =>
    GetAllCoursesDTO(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => CourseApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllCoursesDTOToJson(GetAllCoursesDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
