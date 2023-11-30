import 'package:flutter_app_template/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:flutter_app_template/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:flutter_app_template/ui/views/home/home_view.dart';
import 'package:flutter_app_template/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_app_template/ui/views/counter/counter_view.dart';
import 'package:flutter_app_template/ui/views/login/login_view.dart';
import 'package:flutter_app_template/services/authentication_service.dart';
import 'package:flutter_app_template/services/dio_service.dart';
import 'package:flutter_app_template/ui/views/gooey_edge_demo/gooey_edge_demo_view.dart';
import 'package:flutter_app_template/ui/views/stars_demo/stars_demo_view.dart';
import 'package:flutter_app_template/ui/views/sparkle_party_demo/sparkle_party_demo_view.dart';
import 'package:flutter_app_template/ui/views/verticle_page/verticle_page_view.dart';
import 'package:flutter_app_template/ui/views/trigonometric/trigonometric_view.dart';
import 'package:flutter_app_template/ui/views/squares_demo/squares_demo_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: CounterView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: GooeyEdgeDemoView),
    MaterialRoute(page: StarsDemoView),
    MaterialRoute(page: SparklePartyDemoView),
    MaterialRoute(page: VerticlePageView),
    MaterialRoute(page: TrigonometricView),
    MaterialRoute(page: SquaresDemoView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthenticationService),
    LazySingleton(classType: DioService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
  logger: StackedLogger(),
)
class App {}
