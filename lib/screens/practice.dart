import 'package:seek_speak/app_export.dart';

class Practice extends StatelessWidget {
  const Practice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Syllable " + Get.arguments)),
      body: Container(),
    );
  }
}
