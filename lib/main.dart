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

  populateDb();

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

populateDb() {
  final Box<Exercise> exeBox = Get.find();
  final Box<Syllable> sylBox = Get.find();
  final Box<Recording> recBox = Get.find();

  recBox.removeAll();
  sylBox.removeAll();
  exeBox.removeAll();

  Syllable sylL = Syllable(
      name: 'L',
      icon: 'assets/iconL.svg',
      color: 0xFF0A758F,
      practiceVideoPath: 'assets/videos/seek_speak_practice.mp4');

  Syllable sylS = Syllable(
      name: 'S',
      icon: 'assets/iconS.svg',
      color: 0xFF29CFD6,
      practiceVideoPath: 'assets/videos/seek_speak_practice.mp4');

  Syllable sylR = Syllable(
      name: 'R',
      icon: 'assets/iconR.svg',
      color: 0xFF8487C3,
      practiceVideoPath: 'assets/videos/seek_speak_practice.mp4');

  Syllable sylD = Syllable(
      name: 'D',
      icon: 'assets/iconD.svg',
      color: 0xFFF6B26B,
      practiceVideoPath: 'assets/videos/seek_speak_practice.mp4');

  Syllable sylM = Syllable(
      name: 'M',
      icon: 'assets/iconL.svg',
      color: 0xFF0A758F,
      practiceVideoPath: 'assets/videos/seek_speak_practice.mp4');
  Syllable sylJ = Syllable(
      name: 'J',
      icon: 'assets/iconS.svg',
      color: 0xFF29CFD6,
      practiceVideoPath: 'assets/videos/seek_speak_practice.mp4');
  Syllable sylH = Syllable(
      name: 'H',
      icon: 'assets/iconR.svg',
      color: 0xFF8487C3,
      practiceVideoPath: 'assets/videos/seek_speak_practice.mp4');
  Syllable sylCH = Syllable(
      name: 'CH',
      icon: 'assets/iconD.svg',
      color: 0xFFF6B26B,
      practiceVideoPath: 'assets/videos/seek_speak_practice.mp4');
  Syllable sylA = Syllable(
      name: 'A',
      icon: 'assets/iconL.svg',
      color: 0xFF0A758F,
      practiceVideoPath: 'assets/videos/seek_speak_practice.mp4');

  sylL.exercises.add(Exercise(name: 'Lano', img: 'assets/pics/lano.png'));
  sylL.exercises.add(Exercise(name: 'Lampa', img: 'assets/pics/lamp.png'));
  sylL.exercises.add(Exercise(name: 'Lev', img: 'assets/pics/lev.png'));
  sylL.exercises.add(Exercise(name: 'Limo', img: 'assets/pics/limo.png'));
  sylL.exercises.add(Exercise(name: 'Luk', img: 'assets/pics/luk.png'));
  sylL.exercises.add(Exercise(name: 'Lampa', img: 'assets/pics/lamp.png'));

  sylBox.putMany([sylL, sylS, sylR, sylD, sylM, sylJ, sylH, sylCH, sylA]);
}
