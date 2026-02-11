import 'package:get/get.dart';

import '../modules/auth/views/login_view.dart';
import '../modules/barang-keluar/bindings/barang_keluar_binding.dart';
import '../modules/barang-keluar/views/barang_keluar_view.dart';
import '../modules/barang-masuk/bindings/barang_masuk_binding.dart';
import '../modules/barang-masuk/views/barang_masuk_view.dart';
import '../modules/barang/bindings/barang_binding.dart';
import '../modules/barang/views/barang_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/kategori/bindings/kategori_binding.dart';
import '../modules/kategori/views/kategori_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/ruangan/bindings/ruangan_binding.dart';
import '../modules/ruangan/views/ruangan_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

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
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.BARANG,
      page: () => const BarangView(),
      binding: BarangBinding(),
    ),
    GetPage(
      name: _Paths.KATEGORI,
      page: () => const KategoriView(),
      binding: KategoriBinding(),
    ),
    GetPage(
      name: _Paths.RUANGAN,
      page: () => const RuanganView(),
      binding: RuanganBinding(),
    ),
    GetPage(
      name: _Paths.BARANG_MASUK,
      page: () => const BarangMasukView(),
      binding: BarangMasukBinding(),
    ),
    GetPage(
      name: _Paths.BARANG_KELUAR,
      page: () => const BarangKeluarView(),
      binding: BarangKeluarBinding(),
    ),
  ];
}
