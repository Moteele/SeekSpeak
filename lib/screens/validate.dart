import 'package:seek_speak/app_export.dart';

import '../audio_player.dart';
import '../objectbox.g.dart';

class Validate extends StatelessWidget {
  const Validate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Box<Syllable> sylBox = Get.find();
    Syllable? syl = sylBox.get(Get.arguments[1]);

    return Scaffold(
      appBar: AppBar(title: Text('Validace')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Správně?',
            style: TextStyle(fontSize: 40, color: Colors.white),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: AudioPlayer(
              source: Get.arguments[0],
              showTrash: false,
              onDelete: () {},
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xff29CFD6),
                      minimumSize:
                          Size(MediaQuery.of(context).size.width / 2, 80)),
                  onPressed: () {
                    syl?.index++;
                    sylBox.put(syl!);
                    Get.toNamed('/speak', arguments: Get.arguments[1]);
                  },
                  child: Text('Ano', style: TextStyle(fontSize: 30))),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xffF6B26B),
                      minimumSize:
                          Size(MediaQuery.of(context).size.width / 2, 80)),
                  onPressed: () =>
                      Get.toNamed('/reject', arguments: Get.arguments[1]),
                  child: Text('Ne', style: TextStyle(fontSize: 30)))
            ],
          )
        ],
      ),
    );
  }
}
