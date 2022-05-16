import 'package:objectbox/objectbox.dart';

import 'app_export.dart';

@Entity()
class Recording {
  int id = 0;
  String name = '';
  String recPath = '';
  String imgPath = '';
}

@Entity()
class Syllable {
  int id = 0;
  String name = '';
  Color color = Colors.white;
  String icon = '';
}

@Entity()
class Exercise {
  int id = 0;
  String img = '';
  final syllable = ToOne<Syllable>();
}
