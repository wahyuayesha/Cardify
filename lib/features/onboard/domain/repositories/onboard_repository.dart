abstract class OnboardRepository {
  Future<bool> isFirstTime();
  Future<void> setNotFirstTime();
}
