import 'dart:io';

import 'package:cardify/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class OcrRepository {
  Future<Either<Failure, String>> extractText(File imageFile);
}
