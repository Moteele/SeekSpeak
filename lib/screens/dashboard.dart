import 'package:seek_speak/app_export.dart';
import 'package:seek_speak/objectbox.g.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);

  final Box<Exercise> exeBox = Get.find();
  final Box<Syllable> sylBox = Get.find();
  final Box<Recording> recBox = Get.find();

  @override
  Widget build(BuildContext context) {
    List<Widget> syls =
        sylBox.getAll().map((item) => SylButton(syl: item)).toList();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          actions: [
            IconButton(
              icon: Icon(Icons.start),
              onPressed: () => populateDb(),
            ),
            IconButton(icon: Icon(Icons.stop), onPressed: () => removeDb())
          ],
        ),
        /*
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const ExerciseButton(
              color: Color(0xFF0A758F), name: "L", icon: 'assets/iconL.svg'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              ExerciseButton(
                  color: Color(0xFF29CFD6),
                  name: "S",
                  icon: 'assets/iconS.svg'),
              ExerciseButton(
                  color: Color(0xFF8487C3),
                  name: "R",
                  icon: 'assets/iconR.svg'),
            ],
          ),
          const ExerciseButton(
              color: Color(0xFFF6B26B), name: "D", icon: 'assets/iconD.svg'),
        ],
      ),*/
        body: ListView(
          children: groupSyls(syls),
        ));
  }

// group the Syllable buttons to the pattern 1, 2, 1... per line
  groupSyls(List<Widget> widgets) {
    List<Widget> returnList = [];
    for (int i = 0; i < widgets.length; i++) {
      if (i % 3 == 0) {
        returnList.add(widgets[i]);
      } else if (i % 3 == 2) {
        returnList.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [widgets[i - 1], widgets[i]],
        ));
      }
    }
    if (widgets.length % 3 == 2) {
      returnList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [widgets.last],
      ));
    }
    return returnList
        .map((item) => Padding(
              padding: EdgeInsets.only(top: 70),
              child: item,
            ))
        .toList();
  }

  populateDb() {
    Syllable sylL =
        Syllable(name: 'L', icon: 'assets/iconL.svg', color: 0xFF0A758F);

    Syllable sylS =
        Syllable(name: 'S', icon: 'assets/iconS.svg', color: 0xFF29CFD6);

    Syllable sylR =
        Syllable(name: 'R', icon: 'assets/iconR.svg', color: 0xFF8487C3);

    Syllable sylD =
        Syllable(name: 'D', icon: 'assets/iconD.svg', color: 0xFFF6B26B);

    Syllable sylM =
        Syllable(name: 'M', icon: 'assets/iconL.svg', color: 0xFF0A758F);
    Syllable sylJ =
        Syllable(name: 'J', icon: 'assets/iconS.svg', color: 0xFF29CFD6);
    Syllable sylH =
        Syllable(name: 'H', icon: 'assets/iconR.svg', color: 0xFF8487C3);
    Syllable sylCH =
        Syllable(name: 'CH', icon: 'assets/iconD.svg', color: 0xFFF6B26B);
    Syllable sylA =
        Syllable(name: 'A', icon: 'assets/iconL.svg', color: 0xFF0A758F);

    sylL.exercises.add(Exercise(name: 'Lano', img: 'assets/pics/lano.png'));
    sylL.exercises.add(Exercise(name: 'Lampa', img: 'assets/pics/lamp.png'));
    sylL.exercises.add(Exercise(name: 'Lev', img: 'assets/pics/lev.png'));
    sylL.exercises.add(Exercise(name: 'Limo', img: 'assets/pics/limo.png'));
    sylL.exercises.add(Exercise(name: 'Luk', img: 'assets/pics/luk.png'));
    sylL.exercises.add(Exercise(name: 'Lampa', img: 'assets/pics/lamp.png'));

    sylBox.putMany([sylL, sylS, sylR, sylD, sylM, sylJ, sylH, sylCH, sylA]);
  }

  removeDb() {
    recBox.removeAll();
    sylBox.removeAll();
    exeBox.removeAll();
  }
}

class SylButton extends StatefulWidget {
  Syllable? syl;
  SylButton({Key? key, required this.syl}) : super(key: key);

  @override
  State<SylButton> createState() => _SylButtonState();
}

class _SylButtonState extends State<SylButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Get.toNamed('/practice', arguments: widget.syl?.id);
        },
        child: Stack(alignment: Alignment.center, children: [
          const SizedBox(
            width: 130,
            height: 130,
            child: CircularProgressIndicator(
                value: 0.2,
                backgroundColor: Color(0xFFE5E5E4),
                strokeWidth: 10,
                color: Color(0xFF5DD6F4)),
          ),
          Container(
            width: 100.0,
            height: 100.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(widget.syl?.color ?? 0xFFFFFFFF),
              shape: BoxShape.circle,
            ),
          ),
          SvgPicture.asset(widget.syl?.icon ?? 'assets/iconS.svg'),
          Text(widget.syl?.name ?? 'X',
              style: GoogleFonts.ribeye(fontSize: 20)),
        ]));
  }
}

class ExerciseButton extends StatefulWidget {
  final Color color;
  final String name;
  final String icon;
  const ExerciseButton(
      {Key? key, required this.icon, required this.color, required this.name})
      : super(key: key);

  @override
  State<ExerciseButton> createState() => _ExerciseButtonState();
}

class _ExerciseButtonState extends State<ExerciseButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Get.toNamed('/practice', arguments: widget.name);
        },
        child: Stack(alignment: Alignment.center, children: [
          const SizedBox(
            width: 130,
            height: 130,
            child: CircularProgressIndicator(
                value: 0.2,
                backgroundColor: Color(0xFFE5E5E4),
                strokeWidth: 10,
                color: Color(0xFF5DD6F4)),
          ),
          Container(
            width: 100.0,
            height: 100.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
            ),
          ),
          SvgPicture.asset(widget.icon),
          Text(widget.name, style: GoogleFonts.ribeye(fontSize: 20)),
        ]));
  }
}
