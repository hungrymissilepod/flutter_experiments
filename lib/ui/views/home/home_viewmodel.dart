import 'package:flutter_app_template/app/app.locator.dart';
import 'package:flutter_app_template/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  HomeViewModel(int startingIndex) {
    _counter = startingIndex;
  }

  String get counterLabel => 'Counter is: $_counter';

  int _counter = 0;

  void navigateToGooeyEdgeDemo() {
    _navigationService.navigateToGooeyEdgeDemoView();
  }

  void navigateToStarsDemo() {
    _navigationService.navigateToStarsDemoView();
  }

  void navigateToSparklePartyDemo() {
    _navigationService.navigateToSparklePartyDemoView();
  }

  void navigateToVerticlePageDemo() {
    _navigationService.navigateToVerticlePageView();
  }
}
