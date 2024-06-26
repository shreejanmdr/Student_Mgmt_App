import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/failure/failure.dart';
import 'package:student_management_starter/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:student_management_starter/features/auth/domain/entity/auth_entity.dart';
import 'package:student_management_starter/features/auth/domain/repository/i_auth_repository.dart';

final authRemoteRepository = Provider<IAuthRepository>((ref) {
  return AuthRemoteRepository(
      authRemoteDataSource: ref.read(authRemoteDataSourceProvider));
});

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRemoteRepository({required this.authRemoteDataSource});
  @override
  Future<Either<Failure, bool>> addStudent(AuthEntity auth) {
    return authRemoteDataSource.addStudent(auth);
  }

  @override
  Future<Either<Failure, bool>> login(String username, String password) {
    return authRemoteDataSource.login(
      username: username,
      password: password,
    );
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    return authRemoteDataSource.uploadProfilePicture(file);
  }
}
