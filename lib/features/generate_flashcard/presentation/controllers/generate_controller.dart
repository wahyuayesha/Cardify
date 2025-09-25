import 'dart:io';

import 'package:cardify/features/generate_flashcard/domain/usecases/create_flashcard_image.dart';
import 'package:cardify/features/generate_flashcard/domain/usecases/create_flashcard_text.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class GenerateController extends GetxController {
  final CreateFlashcardText createFlashcardText;
  final CreateFlashcardImage createFlashcardImage;

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var successMessage = ''.obs;

  final ImagePicker imagePicker = ImagePicker();
  File? selectedImage;

  GenerateController({
    required this.createFlashcardImage,
    required this.createFlashcardText,
  });

  Future<void> createFlashcard({String? content}) async {
    isLoading.value = true;
    errorMessage.value = '';
    successMessage.value = '';

    if (selectedImage != null && (content == null || content.isEmpty)) {
      final result = await createFlashcardImage(selectedImage!);
      result.fold(
        (failure) => errorMessage.value = failure.message,
        (_) => successMessage.value = 'Flashcard generated from image!',
      );
    } else if (selectedImage == null && content != null && content.isNotEmpty) {
      final result = await createFlashcardText(content);
      result.fold(
        (failure) => errorMessage.value = failure.message,
        (_) => successMessage.value = 'Flashcard generated from text!',
      );
    } else {
      errorMessage.value = 'Please provide either an image or text (not both).';
    }

    isLoading.value = false;
  }

  Future<void> pickImage(ImageSource source) async {
    errorMessage.value = '';
    selectedImage = null;

    PermissionStatus status;

    if (source == ImageSource.camera) {
      status = await Permission.camera.request();
      if (status.isDenied) {
        errorMessage.value = 'Camera permission denied';
        return;
      }
      if (status.isPermanentlyDenied) {
        openAppSettings();
        return;
      }
    }

    if (source == ImageSource.gallery) {
      status = await Permission.storage.request();
      if (status.isDenied) {
        errorMessage.value = 'Storage permission denied';
        return;
      }
      if (status.isPermanentlyDenied) {
        openAppSettings();
        return;
      }
    }

    final pickedImage = await imagePicker.pickImage(source: source);
    if (pickedImage == null) {
      errorMessage.value = "You have not pick any image";
    } else {
      selectedImage = File(pickedImage.path);
    }
  }
}
