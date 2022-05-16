import 'app_export.dart';
import 'objectbox.g.dart';

late ObjectBox objectbox;

Future<void> main() async {
  // This is required so ObjectBox can get the application directory
  // to store the database in.
  WidgetsFlutterBinding.ensureInitialized();

  objectbox = await ObjectBox.create();
  Store store = Get.find();

  final recBox = store.box<Recording>();
  Get.put(recBox);
  final exeBox = store.box<Exercise>();
  Get.put(exeBox);
  final sylBox = store.box<Syllable>();
  Get.put(sylBox);

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
        textTheme: GoogleFonts.robotoTextTheme(),
      )));
}

class ObjectBox {
  /// The Store of this app.
  late final Store store;

  ObjectBox._create(this.store) {
    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore();
    Get.put(store);
    return ObjectBox._create(store);
  }
}
