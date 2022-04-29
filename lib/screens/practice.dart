import 'package:seek_speak/app_export.dart';

class Practice extends StatelessWidget {
  const Practice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Syllable " + Get.arguments)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 400,
              height: 300,
              color: Colors.white,
              child: Text("video")),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Color(0xFFF6B26B)),
              child: Text(
                "Practice",
                style: TextStyle(fontSize: 40),
              ),
              onPressed: () {
                Get.toNamed('/speak');
              },
            ),
          ),
        ],
      ),
    );
  }
}
