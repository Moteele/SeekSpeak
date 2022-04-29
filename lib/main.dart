import 'app_export.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: AppRoutes.dashboard,
    getPages: AppRoutes.pages,
    theme: ThemeData(
        //backgroundColor: const Color(0xFF00C4CC),
        scaffoldBackgroundColor: const Color(0xFF0D98BA),
        primaryColor: Colors.white,
        /*
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
        ).copyWith(
          primary: const Color(0xFF2B4141),
          secondary: const Color(0xFFC4d6bb),
        ),
        */
        textTheme: GoogleFonts.ribeyeTextTheme()),
  ));
}
