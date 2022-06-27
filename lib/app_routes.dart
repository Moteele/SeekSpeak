import 'screens/accept.dart';
import 'screens/dashboard.dart';
import 'screens/practice.dart';
import 'screens/reject.dart';
import 'screens/speak.dart';
import 'app_export.dart';
import 'screens/validate.dart';

class AppRoutes {
  static String dashboard = '/dashboard';
  static String practice = '/practice';
  static String speak = '/speak';
  static String validate = '/validate';
  static String accept = '/accept';
  static String reject = '/reject';

  static List<GetPage> pages = [
    GetPage(
      name: dashboard,
      page: () => Dashboard(),
    ),
    GetPage(name: practice, page: () => Practice()),
    GetPage(name: speak, page: () => Speak()),
    GetPage(name: validate, page: () => Validate()),
    GetPage(name: accept, page: () => Accept()),
    GetPage(name: reject, page: () => Reject()),
  ];
}
