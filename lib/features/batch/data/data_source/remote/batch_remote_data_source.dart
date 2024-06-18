import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/app/constants/api_endpoint.dart';
import 'package:student_management_starter/core/failure/failure.dart';
import 'package:student_management_starter/core/networking/remote/http_service.dart';
import 'package:student_management_starter/core/shared_prefs/user_shared_prefs.dart';
import 'package:student_management_starter/features/batch/data/dto/get_all_batch_dto.dart';
import 'package:student_management_starter/features/batch/data/model/batch_api_model.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';

final batchRemoteDataSourceProvider = Provider(
  (ref) => BatchRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    batchApiModel: ref.read(batchApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class BatchRemoteDataSource {
  final Dio dio;
  final BatchApiModel batchApiModel;
  final UserSharedPrefs userSharedPrefs;

  BatchRemoteDataSource({
    required this.dio,
    required this.batchApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, bool>> addBatch(BatchEntity batch) async {
    try {
      var response = await dio.post(
        ApiEndpoints.createBatch,
        data: batchApiModel.fromEntity(batch).toJson(),
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

  Future<Either<Failure, List<BatchEntity>>> getAllBatches() async {
    try {
      var response = await dio.get(ApiEndpoints.getAllBatch);
      if (response.statusCode == 200) {
        // 1st way
        // return Right(
        //   (response.data['data'] as List)
        //       .map((batch) => BatchApiModel.fromJson(batch).toEntity())
        //       .toList(),
        // );
        // OR
        // 2nd way
        GetAllBatchDTO batchAddDTO = GetAllBatchDTO.fromJson(response.data);
        return Right(batchApiModel.toEntityList(batchAddDTO.data));
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

  Future<Either<Failure, bool>> deleteBatch(String batchId) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );
      Response response = await dio.delete(
        ApiEndpoints.deleteBatch + batchId,
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
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
