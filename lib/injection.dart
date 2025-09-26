import 'package:cardify/core/const/config.dart';
import 'package:cardify/core/services/database_service.dart'
    show DatabaseService;

import 'package:cardify/features/flashcard/data/datasource/flashcard_local_datasource.dart';
import 'package:cardify/features/flashcard/data/repo_impl/flashcard_repo_impl.dart';
import 'package:cardify/features/flashcard/domain/repositories/flashcard_repository.dart';
import 'package:cardify/features/generate_flashcard/data/datasource/generate_remote_datasource.dart';
import 'package:cardify/features/generate_flashcard/data/repo_impl/generate_repo_impl.dart';
import 'package:cardify/features/generate_flashcard/domain/repositories/generate_repository.dart';
import 'package:cardify/features/generate_flashcard/domain/usecases/create_flashcard_image.dart';
import 'package:cardify/features/generate_flashcard/domain/usecases/create_flashcard_text.dart';
import 'package:cardify/features/generate_flashcard/presentation/controllers/generate_controller.dart';
import 'package:cardify/features/ocr/data/datasource/ocr_local_datasource.dart';
import 'package:cardify/features/ocr/data/repo_impl/ocr_repo_impl.dart';
import 'package:cardify/features/ocr/domain/repository/ocr_repository.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

Future<void> initDependencies() async {
  // DATABASE SERVICE
  // buat instance manual
  final databaseService = DatabaseService();
  await databaseService.init();

  // injek ke GetX
  Get.put<DatabaseService>(databaseService, permanent: true);

  // FLASHCARD
  // datasource
  Get.lazyPut(
    () => FlashcardLocalDataSource(databaseService: databaseService),
    fenix: true,
  );
  // repository
  Get.lazyPut<FlashcardRepository>(
    () => FlashcardRepoImpl(localDataSource: Get.find()),
    fenix: true,
  );

  // usecase

  // controller

  // OCR
  // datasource
  Get.lazyPut(() => OcrLocalDatasource(), fenix: true);
  // repository
  Get.lazyPut<OcrRepository>(
    () => OcrRepoImpl(ocrLocalDatasource: Get.find()),
    fenix: true,
  );

  // GENERATE
  // datasource
  final model = GenerativeModel(
    model: AppConfig.aiModel,
    apiKey: AppConfig.aiApiKey,
  );
  Get.lazyPut<GenerateRemoteDatasource>(
    () => GenerateRemoteDatasource(generativeModel: model),
    fenix: true,
  );

  // repository
  Get.lazyPut<GenerateRepository>(
    () => GenerateRepoImpl(remoteDatasource: Get.find()),
    fenix: true,
  );

  // usecase
  Get.lazyPut(
    () => CreateFlashcardImage(
      generateRepository: Get.find(),
      ocrRepository: Get.find(),
      flashcardRepository: Get.find(),
    ),
    fenix: true,
  );
  Get.lazyPut(
    () => CreateFlashcardText(
      generateRepository: Get.find(),
      flashcardRepository: Get.find(),
    ),
    fenix: true,
  );

  // controller
  Get.lazyPut(
    () => GenerateController(
      createFlashcardImage: Get.find(),
      createFlashcardText: Get.find(),
    ),
    fenix: true,
  );
}
