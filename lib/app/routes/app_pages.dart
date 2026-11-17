import 'package:get/get.dart';
import '../views/umkm_view.dart';

class AppRoutes {
  static const umkmList = '/umkm';

  static final routes = [
    GetPage(name: umkmList, page: () => const UmkmView()),
  ];
}