import 'dart:io';

import 'package:cardify/core/error/failures.dart';
import 'package:cardify/features/ocr/data/datasource/ocr_local_datasource.dart';
import 'package:cardify/features/ocr/domain/repository/ocr_repository.dart';
import 'package:dartz/dartz.dart';

class OcrRepoImpl implements OcrRepository {
  final OcrLocalDatasource ocrLocalDatasource;

  OcrRepoImpl({required this.ocrLocalDatasource});

  // Ekstrak gambar menjadi teks
  @override
  Future<Either<Failure, String>> extractText(File imageFile) async {
    try {
      final text = await ocrLocalDatasource.extractText(imageFile);
      return Right(text);
    } catch (e) {
      return Left(CacheFailure('$e'));
    }
  }
}
