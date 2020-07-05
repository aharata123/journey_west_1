import 'package:get_it/get_it.dart';
import 'package:journeywest/service/ScenarioService.dart';
import 'package:journeywest/viewmodel/LoginViewModel.dart';
import 'package:journeywest/viewmodel/ShoppingCartViewModel.dart';
import 'package:journeywest/viewmodel/admin/scenario/ScenarioDetailViewModel.dart';
import 'package:journeywest/viewmodel/admin/scenario/ScenarioEditViewModel.dart';
import 'package:journeywest/viewmodel/admin/scenario/ScenarioFormViewModel.dart';
import 'package:journeywest/viewmodel/admin/scenario/ScenarioViewModel.dart';

GetIt locator = GetIt();

void setupLocator() {
//  service
  locator.registerLazySingleton<ScenarioService>(() => ScenarioService());

// view model
  locator.registerFactory<ScenarioViewModel>(() => ScenarioViewModel());
  locator.registerFactory<ScenarioFormViewModel>(() => ScenarioFormViewModel());
  locator.registerFactory<ScenarioEditViewModel>(() => ScenarioEditViewModel());
  locator.registerFactory<ScenarioDetailViewModel>(() => ScenarioDetailViewModel());
  locator.registerFactory<LoginViewModel>(() => LoginViewModel());
  locator.registerFactory<ShoppingCartViewModel>(() => ShoppingCartViewModel());
}