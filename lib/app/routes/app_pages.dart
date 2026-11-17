import 'package:get/get.dart';
import '../views/umkm_view.dart';
import '../views/umkm_form_page.dart';

class AppRoutes {
  static const umkmList = '/umkm';
  static const umkmForm = '/umkm/add';

  static final routes = [
    GetPage(name: umkmList, page: () => const UmkmView()),
    GetPage(name: umkmForm, page: () => UmkmFormPage()),
  ];
}