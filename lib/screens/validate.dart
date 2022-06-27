import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:seek_speak/app_export.dart';
import 'package:just_audio/just_audio.dart' as ap;

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
              source: ap.AudioSource.uri(Uri.parse(Get.arguments[0])),
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
                    saveRecord(Get.arguments[0], true);
                    Get.toNamed('/speak', arguments: Get.arguments[1]);
                  },
                  child: Text('Ano', style: TextStyle(fontSize: 30))),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xffF6B26B),
                      minimumSize:
                          Size(MediaQuery.of(context).size.width / 2, 80)),
                  onPressed: () {
                    saveRecord(Get.arguments[0], true);

                    Get.toNamed('/reject', arguments: Get.arguments[1]);
                  },
                  child: Text('Ne', style: TextStyle(fontSize: 30)))
            ],
          )
        ],
      ),
    );
  }

  Future saveRecord(String _tmpPath, bool _correct) async {
    Box<Syllable> sylBox = Get.find();
    Syllable? syl = sylBox.get(Get.arguments[1]);

    Box<Recording> recBox = Get.find();
    Recording rec = Recording();
    recBox.put(rec);
    Query<Recording> query = recBox.query().build();
    int _id = query.find().last.id;
    final directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/recording_syl${syl?.name ?? 'X'}_$_id.m4a';
    path = (await moveFile(File(_tmpPath), path)).path;
    rec.id = _id;
    rec.correct = _correct;
    rec.recordingPath = path;
    recBox.put(rec);
    return;
  }

  Future<File> moveFile(File sourceFile, String newPath) async {
    try {
      // prefer using rename as it is probably faster
      return await sourceFile.rename(newPath);
    } on FileSystemException catch (e) {
      // if rename fails, copy the source file and then delete it
      final newFile = await sourceFile.copy(newPath);
      await sourceFile.delete();
      return newFile;
    }
  }
}
