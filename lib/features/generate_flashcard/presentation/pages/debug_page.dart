import 'package:cardify/features/generate_flashcard/presentation/controllers/generate_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

class DebugPage extends StatelessWidget {
  DebugPage({super.key});
  final GenerateController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await controller.pickImage(ImageSource.camera);
                      await controller.createFlashcard();
                    },
                    child: Text('Ambil Gambar'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await controller.pickImage(ImageSource.gallery);
                      await controller.createFlashcard();
                    },
                    child: Text('Pilih Gambar'),
                  ),
                ],
              ),
              SizedBox(height: 20),

              Text(''),
            ],
          ),

          // snackbar listener
          // snackbar listener
          Obx(() {
            if (controller.errorMessage.isNotEmpty) {
              print(controller.errorMessage.value);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Get.snackbar(
                  'Error',
                  '',
                  messageText: Text(
                    controller.errorMessage.value,
                    maxLines: 3, // biar gak kepanjangan
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  ),
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.redAccent,
                );
                controller.errorMessage.value = '';
              });
            }

            if (controller.successMessage.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Get.snackbar(
                  'Success',
                  '',
                  messageText: Text(
                    controller.successMessage.value,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  ),
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                );
                controller.successMessage.value = '';
              });
            }

            return SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
