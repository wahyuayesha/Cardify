import 'package:cardify/features/onboard/domain/repositories/onboard_repository.dart';

class SetNotFirstTimeUsecase {
  final OnboardRepository onboardRepository;

  SetNotFirstTimeUsecase({required this.onboardRepository});

  Future<void> call() async => await onboardRepository.setNotFirstTime();
}
