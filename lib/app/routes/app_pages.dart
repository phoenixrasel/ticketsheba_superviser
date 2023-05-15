import 'package:get/get.dart';

import '../modules/booking_page/bindings/booking_page_binding.dart';
import '../modules/booking_page/views/booking_page_view.dart';
import '../modules/confirm_page/bindings/confirm_page_binding.dart';
import '../modules/confirm_page/views/confirm_page_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/quick_booking_page/bindings/quick_booking_page_binding.dart';
import '../modules/quick_booking_page/views/quick_booking_page_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/stand_up/bindings/stand_up_binding.dart';
import '../modules/stand_up/views/stand_up_view.dart';
import '../modules/standup_page/bindings/standup_page_binding.dart';
import '../modules/standup_page/views/standup_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING_PAGE,
      page: () => const BookingPageView(),
      binding: BookingPageBinding(),
    ),
    GetPage(
      name: _Paths.QUICK_BOOKING_PAGE,
      page: () => const QuickBookingPageView(),
      binding: QuickBookingPageBinding(),
    ),
    GetPage(
      name: _Paths.STAND_UP,
      page: () => const StandUpView(),
      binding: StandUpBinding(),
    ),
    GetPage(
      name: _Paths.CONFIRM_PAGE,
      page: () => const ConfirmPageView(),
      binding: ConfirmPageBinding(),
    ),
    GetPage(
      name: _Paths.STANDUP_PAGE,
      page: () => const StandupPageView(),
      binding: StandupPageBinding(),
    ),
  ];
}
