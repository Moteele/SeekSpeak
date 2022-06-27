import 'package:objectbox/objectbox.dart';

@Entity()
class Recording {
  int id;
  String recordingPath;
  bool correct;
  final exercise = ToOne<Exercise>();

  Recording({this.id = 0, this.recordingPath = '', this.correct = false});
}

@Entity()
class Syllable {
  int id;
  String name;
  int color;
  String icon;
  String practiceVideoPath;

  @Backlink('syllable')
  final exercises = ToMany<Exercise>();
  int index;

  Syllable(
      {this.id = 0,
      this.name = '',
      this.color = 0x0,
      this.icon = '',
      this.index = 0,
      this.practiceVideoPath = ''});
}

@Entity()
class Exercise {
  int id;
  String img;
  String name;
  final syllable = ToOne<Syllable>();

  Exercise({this.id = 0, this.img = '', this.name = ''});
}
