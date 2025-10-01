import 'package:cardify/features/onboard/domain/usecases/isFirstTime_usecase.dart';
import 'package:cardify/features/onboard/domain/usecases/setNotFirstTime_usecase.dart';
import 'package:get/get.dart';

class OnboardController extends GetxController {
  final IsfirstTimeUsecase isfirstTimeUsecase;
  final SetNotFirstTimeUsecase setNotFirstTimeUsecase;

  OnboardController({
    required this.isfirstTimeUsecase,
    required this.setNotFirstTimeUsecase,
  });
  
  Future<bool> firstTimeStatus() async {
    final status = await isfirstTimeUsecase();
    return status;
  }

  Future<void> setToNotFristTime() async => await setNotFirstTimeUsecase();
}
