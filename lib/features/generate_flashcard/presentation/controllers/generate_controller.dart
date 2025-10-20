import 'dart:io';

import 'package:cardify/features/flashcard/presentation/controller/flashcard_controller.dart';
import 'package:cardify/features/flashcard/presentation/pages/home_page.dart';
import 'package:cardify/features/generate_flashcard/domain/usecases/create_flashcard_image.dart';
import 'package:cardify/features/generate_flashcard/domain/usecases/create_flashcard_text.dart';
import 'package:cardify/features/main/presentation/pages/main_page.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class GenerateController extends GetxController {
  final FlashcardController flashcardController = Get.find();
  final CreateFlashcardText createFlashcardText;
  final CreateFlashcardImage createFlashcardImage;
  final ImagePicker imagePicker = ImagePicker();

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var successMessage = ''.obs;
  File? selectedImage;

  GenerateController({
    required this.createFlashcardImage,
    required this.createFlashcardText,
  });

  @override
  void onInit() {
    super.onInit();

    // tampilkan error sekali tiap kali berubah
    ever(errorMessage, (msg) {
      if (msg.toString().isNotEmpty) {
        Get.snackbar(
          'Error',
          msg.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );
        errorMessage.value = '';
      }
    });

    // tampilkan success sekali tiap kali berubah
    ever(successMessage, (msg) {
      if (msg.toString().isNotEmpty) {
        Get.snackbar(
          'Success',
          msg.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
        );
        Get.to(() => HomePage());
        successMessage.value = '';
      }
    });
  }

  // CREATE FLASHCARD
  Future<void> createFlashcard({String? content}) async {
    // reset variabel
    isLoading.value = true;
    errorMessage.value = '';
    successMessage.value = '';

    // create flashcard sesuai kondisi input (gambar/konten teks)
    if (selectedImage != null && (content == null || content.isEmpty)) {
      // create flashcard dari gambar
      final result = await createFlashcardImage(selectedImage!);
      result.fold((failure) => errorMessage.value = failure.message, (_) async {
        successMessage.value = 'Flashcard generated from image!';
        // fetch ulang flashcards setelah membuat baru
        await flashcardController.getUserFlashcards();
        await flashcardController.getRecentUserFlashcards();
      });
    } else if (selectedImage == null && content != null && content.isNotEmpty) {
      // create flashcard dari konten teks
      final result = await createFlashcardText(content);
      result.fold((failure) => errorMessage.value = failure.message, (_) async {
        successMessage.value = 'Flashcard generated from text!';
        // fetch ulang flashcards setelah membuat baru
        await flashcardController.getUserFlashcards();
        await flashcardController.getRecentUserFlashcards();
      });
    }
    isLoading.value = false;
  }

  // MEMILIH GAMBAR
  Future<void> pickImage(ImageSource source) async {
    errorMessage.value = '';
    selectedImage = null;

    PermissionStatus status;

    if (source == ImageSource.camera) {
      // izin kamera
      status = await Permission.camera.request();
      if (status.isDenied) {
        errorMessage.value = 'Camera permission denied';
        return;
      }
      if (status.isPermanentlyDenied) {
        await openAppSettings();
        return;
      }
    }

    if (source == ImageSource.gallery) {
      // cek versi android
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        final sdkInt = androidInfo.version.sdkInt;

        if (sdkInt >= 33) {
          // android 13+ (API 33 ke atas)
          status = await Permission.photos.request();
        } else {
          // android 10–12 (API 29–32)
          status = await Permission.storage.request();
        }

        if (status.isDenied) {
          errorMessage.value = 'Gallery permission denied';
          return;
        }
        if (status.isPermanentlyDenied) {
          await openAppSettings();
          return;
        }
      }
    }

    // ambil gambar
    final pickedImage = await imagePicker.pickImage(source: source);
    if (pickedImage == null) {
      errorMessage.value = "You have not picked any image";
    } else {
      selectedImage = File(pickedImage.path);
    }
  }
}
