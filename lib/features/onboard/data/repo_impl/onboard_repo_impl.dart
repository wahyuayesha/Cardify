import 'package:cardify/features/onboard/data/datasource/onboard_local_datasource.dart';
import 'package:cardify/features/onboard/domain/repositories/onboard_repository.dart';

class OnboardRepoImpl implements OnboardRepository {
  final OnboardLocalDatasource onboardLocalDatasource;

  OnboardRepoImpl({required this.onboardLocalDatasource});

  @override
  Future<bool> isFirstTime() async {
    return await onboardLocalDatasource.isFirstTime();
  }

  @override
  Future<void> setNotFirstTime() async {
    await onboardLocalDatasource.setNotFirstTime();
  }
}
