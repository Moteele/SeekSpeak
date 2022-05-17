import '../app_export.dart';
import '../objectbox.g.dart';

class Reject extends StatelessWidget {
  const Reject({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Box<Syllable> sylBox = Get.find();
    Syllable? syl = sylBox.get(Get.arguments);
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Chceš to zkusit znovu?',
            style: TextStyle(fontSize: 30, color: Colors.white)),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color(0xff29CFD6),
                minimumSize: Size(MediaQuery.of(context).size.width / 2, 80)),
            onPressed: () {
              Get.toNamed('/speak', arguments: Get.arguments);
            },
            child: Text('Ano', style: TextStyle(fontSize: 30))),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color(0xff29CFD6),
                minimumSize: Size(MediaQuery.of(context).size.width / 2, 80)),
            onPressed: () {
              syl?.index++;
              sylBox.put(syl!);
              Get.offAndToNamed('/dashboard');
            },
            child: Text('Ne', style: TextStyle(fontSize: 30))),
      ],
    ));
  }
}
