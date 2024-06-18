import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_management_starter/features/auth/domain/entity/auth_entity.dart';
import 'package:student_management_starter/features/batch/data/model/batch_api_model.dart';
import 'package:student_management_starter/features/course/data/model/course_api_model.dart';

final authApiModelProvider = Provider((ref) => const AuthApiModel.empty());

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final String fname;
  final String lname;
  final String phone;
  final String? image;
  final String username;
  final String password;
  final BatchApiModel batch;
  final List<CourseApiModel> courses;

  const AuthApiModel(
      {required this.id,
      required this.fname,
      required this.lname,
      required this.phone,
      this.image,
      required this.username,
      required this.password,
      required this.batch,
      required this.courses});

  // Empty api model
  const AuthApiModel.empty()
      : id = '',
        fname = '',
        lname = '',
        phone = '',
        image = '',
        username = '',
        password = '',
        batch = const BatchApiModel.empty(),
        courses = const [];

  // Convert Hive Object to Entity
  AuthEntity toEntity() => AuthEntity(
        id: id,
        fname: fname,
        lname: lname,
        phone: phone,
        batch: batch.toEntity(),
        courses: const CourseApiModel.empty().toEntityList(courses),
        username: username,
        password: password,
      );

  // Convert Entity to Hive Object
  AuthApiModel toApiModel(AuthEntity entity) => AuthApiModel(
        id: id,
        fname: entity.fname,
        lname: entity.lname,
        phone: entity.phone,
        batch: const BatchApiModel.empty().fromEntity(entity.batch),
        courses: const CourseApiModel.empty().fromEntityList(entity.courses),
        username: entity.username,
        password: entity.password,
      );

  // Convert Entity List to Hive List
  List<AuthApiModel> toHiveApiList(List<AuthEntity> entities) =>
      entities.map((entity) => toApiModel(entity)).toList();

  // From Json()
  factory AuthApiModel.fromJson(Map<String, dynamic> json) {
    return AuthApiModel(
      id: json['_id'],
      fname: json['fname'],
      lname: json['lname'],
      phone: json['phone'],
      image: json['image'],
      username: json['username'],
      password: json['password'],
      batch: BatchApiModel.fromJson(json['batch']),
      courses: json['course'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fname': fname,
      'lname': lname,
      'phone': phone,
      'image': image,
      'username': username,
      'password': password,
      'batch': batch.batchId,
      'course': courses.map((e) => e.courseId).toList(),
    };
  }

  @override
  List<Object?> get props =>
      [fname, lname, phone, image, username, password, batch, courses];
}
