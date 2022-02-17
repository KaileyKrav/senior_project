import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import 'bpm_chart.dart';

class CalcHeartPage extends StatefulWidget {
  @override
  CalcHeartPageView createState() {
    return CalcHeartPageView();
  }
}
class CalcHeartPageView extends State<CalcHeartPage> {
  bool _toggled = false;
  bool _processing = false;
  double _alpha = 0.3;
  int _bpm = 0;
  List<SensorValue> _data = [];
  CameraController?  _controller;

  void _toggle() {
    _initController().then((onValue) {
      Wakelock.enable();
      setState(() {
        _toggled = true;
        _processing = false;
    });
      _updateBPM();
    });
  }

    void _untoggle() {
    _disposeController();
    Wakelock.disable();
      setState(() {
        _toggled = false;
        _processing = false;
      });
    }

    Future<void> _initController() async {
      try {
        List _cameras = await availableCameras();
        _controller = CameraController(_cameras.first, ResolutionPreset.low);
        await _controller?.initialize();
        Future.delayed(Duration(milliseconds: 500)).then((onValue) {
          _controller!.setFlashMode(FlashMode.torch);
        });
        _controller!.startImageStream((CameraImage image)  {
          if (!_processing) {
            setState(() {
              _processing = true;
            });
            _scanImage(image);
          }
        });
      }
      catch (Exception) {
        print(Exception);
      }
    }

    _disposeController() {
      _controller?.dispose();
      _controller = null;
    }
    
    @override
    void dispose() {
      _disposeController();
      super.dispose();
    }
    
    _scanImage(CameraImage image) {
      double _avg = 
          image.planes.first.bytes.reduce((value, element) => value + element) /
            image.planes.first.bytes.length;
      if (_data.length >= 50) {
        _data.removeAt(0);
      }
      setState(() {
        _data.add(SensorValue(DateTime.now(), _avg));
      });
      Future.delayed(Duration(milliseconds: 1000 ~/ 30)).then((onValue) {
        setState(() {
          _processing = false;
        });
      });
    }

    _updateBPM() async {
    List<SensorValue> _values;
    double _avg;
    int _n;
    double _m;
    double _threshold;
    double _bpm;
    int _counter;
    int _previous;
    while (_toggled) {
      _values = List.from(_data);
      _avg = 0;
      _n = _values.length;
      _m = 0;
      _values.forEach((SensorValue value) {
        _avg += value.value / _n;
        if (value.value > _m) _m = value.value;
      });
      _threshold = (_m + _avg) /2;
      _bpm = 0;
      _counter = 0;
      _previous = 0;
      for (int i = 1; i < _n; i++) {
        if (_values[i - 1].value < _threshold &&
        _values[i].value > _threshold) {
          if (_previous != 0) {
            _counter++;
            _bpm += 60000 / (_values[i].time.millisecondsSinceEpoch - _previous);
          }
          _previous = _values[i].time.millisecondsSinceEpoch;
        }
      }
      if (_counter > 0) {
        _bpm = _bpm / _counter;
        print(_bpm);
        setState(() {
          this._bpm = ((1 - _alpha) * this._bpm + _alpha * _bpm).toInt();
        });
      }
      await Future.delayed(Duration(milliseconds: (1000 * 50 / 30).round()));
    }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: _controller == null
                      ? Container()
                      : CameraPreview(_controller!),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(_bpm > 30 && _bpm < 150 ? _bpm.toString() : "--"),
                ),
              ),
            ],
              ),
            ),
        Expanded(
        child: Center(
          child: IconButton(
            icon: Icon(_toggled ? Icons.favorite : Icons.favorite_border),
            color: Colors.redAccent,
            iconSize: 128,
            onPressed: () {
              if(_toggled) {
                _untoggle();
              }
              else {
                _toggle();
              }
            }
          ),
        ),
      ),
      Expanded(
        child: Container(
          margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
          color: Colors.white70,
        ),
          child: BPMChart(_data),
      ),
      ),
      ],
    ),
      ),
    );
  }

}