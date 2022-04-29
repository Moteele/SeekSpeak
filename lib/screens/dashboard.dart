import 'package:seek_speak/app_export.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ExerciseButton(color: Color(0xFF0A758F), name: "L"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ExerciseButton(color: Color(0xFF29CFD6), name: "S"),
              ExerciseButton(color: Color(0xFF8487C3), name: "R"),
            ],
          ),
          ExerciseButton(color: Color(0xFFF6B26B), name: "D"),
        ],
      ),
    );
  }
}

class ExerciseButton extends StatefulWidget {
  final Color color;
  final String name;
  const ExerciseButton({Key? key, required this.color, required this.name})
      : super(key: key);

  @override
  State<ExerciseButton> createState() => _ExerciseButtonState();
}

class _ExerciseButtonState extends State<ExerciseButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Container(
        width: 130,
        height: 130,
        child: CircularProgressIndicator(
            value: 0.2,
            backgroundColor: Color(0xFFE5E5E4),
            strokeWidth: 10,
            color: Color(0xFF5DD6F4)),
      ),
      GestureDetector(
        child: Container(
          width: 100.0,
          height: 100.0,
          alignment: Alignment.center,
          decoration: new BoxDecoration(
            color: widget.color,
            shape: BoxShape.circle,
          ),
          child: Text(
            widget.name,
            style: TextStyle(fontSize: 20),
          ),
        ),
        onTap: () {
          Get.toNamed('/practice', arguments: widget.name);
        },
      ),
    ]);
  }
}
