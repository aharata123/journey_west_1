import 'package:get_it/get_it.dart';
import 'package:journeywest/service/ActorService.dart';
import 'package:journeywest/service/ScenarioService.dart';
import 'package:journeywest/service/ToolService.dart';
import 'package:journeywest/viewmodel/LoginViewModel.dart';
import 'package:journeywest/viewmodel/ShoppingCartViewModel.dart';
import 'package:journeywest/viewmodel/admin/actor/ActorEditViewModel.dart';
import 'package:journeywest/viewmodel/admin/actor/ActorFormViewModel.dart';
import 'package:journeywest/viewmodel/admin/actor/ActorViewModel.dart';
import 'package:journeywest/viewmodel/admin/scenario/ScenarioDetailViewModel.dart';
import 'package:journeywest/viewmodel/admin/scenario/ScenarioEditViewModel.dart';
import 'package:journeywest/viewmodel/admin/scenario/ScenarioFormViewModel.dart';
import 'package:journeywest/viewmodel/admin/scenario/ScenarioViewModel.dart';
import 'package:journeywest/viewmodel/admin/tool/ToolEditViewModel.dart';
import 'package:journeywest/viewmodel/admin/tool/ToolFormViewModel.dart';
import 'package:journeywest/viewmodel/admin/tool/ToolViewModel.dart';

GetIt locator = GetIt();

void setupLocator() {
//  service
  locator.registerLazySingleton<ScenarioService>(() => ScenarioService());
  locator.registerLazySingleton<ActorService>(() => ActorService());
  locator.registerLazySingleton<ToolService>(() => ToolService());

// view model
  locator.registerFactory<ScenarioViewModel>(() => ScenarioViewModel());
  locator.registerFactory<ScenarioFormViewModel>(() => ScenarioFormViewModel());
  locator.registerFactory<ScenarioEditViewModel>(() => ScenarioEditViewModel());
  locator.registerFactory<ScenarioDetailViewModel>(() => ScenarioDetailViewModel());

  locator.registerFactory<LoginViewModel>(() => LoginViewModel());
  locator.registerFactory<ShoppingCartViewModel>(() => ShoppingCartViewModel());

  locator.registerFactory<ActorViewModel>(() => ActorViewModel());
  locator.registerFactory<ActorFormViewModel>(() => ActorFormViewModel());
  locator.registerFactory<ActorEditViewModel>(() => ActorEditViewModel());

  locator.registerFactory<ToolViewModel>(() => ToolViewModel());
  locator.registerFactory<ToolFormViewModel>(() => ToolFormViewModel());
  locator.registerFactory<ToolEditViewModel>(() => ToolEditViewModel());
}