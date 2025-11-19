import 'package:get/get.dart';
import 'package:sokrio_technologies_ltd/features/home/view/user_details_view.dart';
import '../../features/home/bindings.dart';
import '../../features/home/view/home_view.dart';
import '../../features/splash/bindings.dart';
import '../../features/splash/view/splash_view.dart';

class RouteService {
  static const splashView = '/splash';
  static const homeView = '/home';
  static const userDetailsView = '/user-details-view';

  static final pages = [
    GetPage(name: splashView, page: () => const SplashView(), binding: SplashBinding()),
    GetPage(name: homeView, page: () => const HomeView(), binding: HomeBinding()),
    GetPage(name: userDetailsView, page: () => const UserDetailsView(), binding: HomeBinding()),
  ];
}
