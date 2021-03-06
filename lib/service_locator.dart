import 'package:get_it/get_it.dart';
import 'package:journeywest/service/ActorService.dart';
import 'package:journeywest/service/ScenarioService.dart';
import 'package:journeywest/service/ShoppingCartService.dart';
import 'package:journeywest/service/ToolService.dart';
import 'package:journeywest/viewmodel/LoginViewModel.dart';
import 'package:journeywest/viewmodel/ShoppingCartViewModel.dart';
import 'package:journeywest/viewmodel/admin/actor/ActorDetailViewModel.dart';
import 'package:journeywest/viewmodel/admin/actor/ActorEditViewModel.dart';
import 'package:journeywest/viewmodel/admin/actor/ActorFormViewModel.dart';
import 'package:journeywest/viewmodel/admin/actor/ActorViewModel.dart';
import 'package:journeywest/viewmodel/admin/scenario/ListActorsViewModel.dart';
import 'package:journeywest/viewmodel/admin/scenario/ListToolsViewModel.dart';
import 'package:journeywest/viewmodel/admin/scenario/ScenarioDetailViewModel.dart';
import 'package:journeywest/viewmodel/admin/scenario/ScenarioEditViewModel.dart';
import 'package:journeywest/viewmodel/admin/scenario/ScenarioFormViewModel.dart';
import 'package:journeywest/viewmodel/admin/scenario/ScenarioViewModel.dart';
import 'package:journeywest/viewmodel/admin/scenario/ShoppingCartForToolViewModel.dart';
import 'package:journeywest/viewmodel/admin/tool/ToolDetailViewModel.dart';
import 'package:journeywest/viewmodel/admin/tool/ToolEditViewModel.dart';
import 'package:journeywest/viewmodel/admin/tool/ToolFormViewModel.dart';
import 'package:journeywest/viewmodel/admin/tool/ToolViewModel.dart';
import 'package:journeywest/viewmodel/user/UserHistoryViewModel.dart';
import 'package:journeywest/viewmodel/user/UserScheduleViewModel.dart';

GetIt locator = GetIt();

void setupLocator() {
//  service
  locator.registerLazySingleton<ScenarioService>(() => ScenarioService());
  locator.registerLazySingleton<ActorService>(() => ActorService());
  locator.registerLazySingleton<ToolService>(() => ToolService());
  locator.registerLazySingleton<ShoppingCartService>(() => ShoppingCartService());

// view model
  locator.registerFactory<ScenarioViewModel>(() => ScenarioViewModel());
  locator.registerFactory<ScenarioFormViewModel>(() => ScenarioFormViewModel());
  locator.registerFactory<ScenarioEditViewModel>(() => ScenarioEditViewModel());
  locator.registerFactory<ScenarioDetailViewModel>(() => ScenarioDetailViewModel());

  locator.registerFactory<LoginViewModel>(() => LoginViewModel());
  locator.registerFactory<ShoppingCartViewModel>(() => ShoppingCartViewModel());
  locator.registerFactory<ShoppingCartForToolViewModel>(() => ShoppingCartForToolViewModel());

  locator.registerFactory<ActorViewModel>(() => ActorViewModel());
  locator.registerFactory<ActorFormViewModel>(() => ActorFormViewModel());
  locator.registerFactory<ActorEditViewModel>(() => ActorEditViewModel());
  locator.registerFactory<ActorDetailViewModel>(() => ActorDetailViewModel());

  locator.registerFactory<ToolViewModel>(() => ToolViewModel());
  locator.registerFactory<ToolFormViewModel>(() => ToolFormViewModel());
  locator.registerFactory<ToolEditViewModel>(() => ToolEditViewModel());
  locator.registerFactory<ToolDetailViewModel>(() => ToolDetailViewModel());

  locator.registerFactory<ListActorsViewModel>(() => ListActorsViewModel());
  locator.registerFactory<ListToolsViewModel>(() => ListToolsViewModel());

  locator.registerFactory<UserHistoryViewModel>(() => UserHistoryViewModel());
  locator.registerFactory<UserScheduleViewModel>(() => UserScheduleViewModel());
}