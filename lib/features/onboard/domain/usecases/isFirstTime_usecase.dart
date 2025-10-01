import 'package:cardify/features/onboard/domain/repositories/onboard_repository.dart';

class IsfirstTimeUsecase {
  final OnboardRepository onboardRepository;

  IsfirstTimeUsecase({required this.onboardRepository});

  Future<bool> call() async {
    return await onboardRepository.isFirstTime();
  }
}
