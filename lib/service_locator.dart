import 'package:get_it/get_it.dart';
import 'package:journeywest/service/ScenarioService.dart';
import 'package:journeywest/view/admin/ScenarioEditPage.dart';
import 'package:journeywest/viewmodel/ScenarioDetailViewModel.dart';
import 'package:journeywest/viewmodel/ScenarioEditViewModel.dart';
import 'package:journeywest/viewmodel/ScenarioFormViewModel.dart';
import 'package:journeywest/viewmodel/ScenarioViewModel.dart';

GetIt locator = GetIt();

void setupLocator() {
//  service
  locator.registerLazySingleton<ScenarioService>(() => ScenarioService());

// view model
  locator.registerFactory<ScenarioViewModel>(() => ScenarioViewModel());
  locator.registerFactory<ScenarioFormViewModel>(() => ScenarioFormViewModel());
  locator.registerFactory<ScenarioEditViewModel>(() => ScenarioEditViewModel());
  locator.registerFactory<ScenarioDetailViewModel>(() => ScenarioDetailViewModel());
}