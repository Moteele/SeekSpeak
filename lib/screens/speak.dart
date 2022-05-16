import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seek_speak/app_export.dart';
import 'package:record/record.dart';
import '../audio_player.dart';

import '../objectbox.g.dart';

class Speak extends StatelessWidget {
  Speak({Key? key}) : super(key: key);
  final Store store = Get.find();

  @override
  Widget build(BuildContext context) {
    final recBox = store.box<Recording>();
    Recording? rec = recBox.get(5);

    return Scaffold(
        appBar: AppBar(title: Text("Syllable " + Get.arguments)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children: [
              Image.asset(
                'assets/pics/lamp2.png',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.volume_up,
                    size: 50,
                  ),
                  Text(rec!.name,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 40)),
                ],
              ),
            ]),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: AudioRecorder(onStop: (path) {
                Get.toNamed('validate');
              }),
            ),
          ],
        ));
  }
}

class AudioRecorder extends StatefulWidget {
  final void Function(String path) onStop;

  const AudioRecorder({
    Key? key,
    required this.onStop,
  }) : super(key: key);

  @override
  _AudioRecorderState createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  bool _isRecording = false;
  bool _isPaused = false;
  int _recordDuration = 0;
  Timer? _timer;
  Timer? _ampTimer;
  final _audioRecorder = Record();
  Amplitude? _amplitude;
  int _countdownTime = 3;

  bool _countdown = false;

  @override
  void initState() {
    _isRecording = false;
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ampTimer?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _countdown
            ? Text(_countdownTime.toString(),
                style: TextStyle(fontSize: 40, color: Colors.white))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildRecordStopControl(),
                  const SizedBox(width: 20),
                  _buildPauseResumeControl(),
                  const SizedBox(width: 20),
                  _isRecording || _isPaused ? _buildTimer() : SizedBox.shrink()
                ],
              ),
        /*
        if (_amplitude != null) ...[
          const SizedBox(height: 40),
          Text('Current: ${_amplitude?.current ?? 0.0}'),
          Text('Max: ${_amplitude?.max ?? 0.0}'),
          
        ],
        */
      ],
    );
  }

  Widget _buildRecordStopControl() {
    late Icon icon;
    late Color color;

    if (_isRecording || _isPaused) {
      icon = const Icon(Icons.stop, color: Colors.white, size: 30);
      color = Colors.white.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = Icon(Icons.mic, color: theme.primaryColor, size: 80);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: _isRecording || _isPaused
              ? SizedBox(width: 56, height: 56, child: icon)
              : SizedBox(width: 90, height: 90, child: icon),
          onTap: () {
            _isRecording ? _stop() : _start();
          },
        ),
      ),
    );
  }

  Widget _buildPauseResumeControl() {
    if (!_isRecording && !_isPaused) {
      return const SizedBox.shrink();
    }

    late Icon icon;
    late Color color;

    if (!_isPaused) {
      icon = const Icon(Icons.pause, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = const Icon(Icons.play_arrow, color: Colors.red, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56, height: 56, child: icon),
          onTap: () {
            _isPaused ? _resume() : _pause();
          },
        ),
      ),
    );
  }

  Widget _buildTimer() {
    final String minutes = _formatNumber(_recordDuration ~/ 60);
    final String seconds = _formatNumber(_recordDuration % 60);

    return Text(
      '$minutes : $seconds',
      style: const TextStyle(color: Colors.red),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }

    return numberStr;
  }

  countDownTimer() async {
    setState(() {
      _countdown = true;
    });
    for (int x = 3; x > 0; x--) {
      await Future.delayed(Duration(seconds: 1)).then((_) {
        setState(() {
          _countdownTime -= 1;
        });
      });
      setState(() {
        _countdown = false;
      });
    }
  }

  Future<void> _start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        // We don't do anything with this but printing
        final isSupported = await _audioRecorder.isEncoderSupported(
          AudioEncoder.aacLc,
        );
        if (kDebugMode) {
          print('${AudioEncoder.aacLc.name} supported: $isSupported');
        }

        await _audioRecorder.start(encoder: AudioEncoder.opus);
        await _audioRecorder.pause();
        await countDownTimer();
        await _audioRecorder.resume();

        bool isRecording = await _audioRecorder.isRecording();
        setState(() {
          _isRecording = isRecording;
          _recordDuration = 0;
        });

        _startTimer();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _stop() async {
    _timer?.cancel();
    _ampTimer?.cancel();
    final path = await _audioRecorder.stop();

    widget.onStop(path!);

    setState(() => _isRecording = false);
  }

  Future<void> _pause() async {
    _timer?.cancel();
    _ampTimer?.cancel();
    await _audioRecorder.pause();

    setState(() => _isPaused = true);
  }

  Future<void> _resume() async {
    _startTimer();
    await _audioRecorder.resume();

    setState(() => _isPaused = false);
  }

  void _startTimer() {
    _timer?.cancel();
    _ampTimer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });

    _ampTimer =
        Timer.periodic(const Duration(milliseconds: 200), (Timer t) async {
      _amplitude = await _audioRecorder.getAmplitude();
      setState(() {});
    });
  }
}
