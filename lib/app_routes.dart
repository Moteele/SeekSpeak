import 'screens/dashboard.dart';
import 'screens/practice.dart';
import 'screens/speak.dart';
import 'app_export.dart';

class AppRoutes {
  static String dashboard = '/dashboard';
  static String practice = '/practice';
  static String speak = '/speak';

  static List<GetPage> pages = [
    GetPage(
      name: dashboard,
      page: () => Dashboard(),
    ),
    GetPage(name: practice, page: () => Practice()),
    GetPage(name: speak, page: () => Speak())
  ];
}
