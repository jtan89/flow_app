import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wave_progress_widget/wave_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'StorageService.dart';
import 'service_locator.dart';

class RewardsWidget extends StatefulWidget {
  RewardsWidget();

  @override
  State<StatefulWidget> createState() {
    return RewardsWidgetState();
  }
}

class RewardsWidgetState extends State<RewardsWidget> {
  RewardsWidgetState();

  StorageService _storageService = locator<StorageService>();
  double _wavePercent;
  double _rewardPoints;
  int pinInput;
  int validPin = 12345;

  @override
  void initState() {
    super.initState();
    _getWaveProgress('progress').then((value) {
      setState(() {
        _initializeRewards(value);
      });
    });
  }

  ////////////////////////////////////
  //METHODS TO HANDLE REWARD VALUES//
  //////////////////////////////////

  Future<double> _getWaveProgress(key) async {
    return _storageService.getDoubleValue(key);
  }

  Future<void> _initializeRewards(value) async {
    if (value <= 90.0) {
      this._wavePercent = value;
    } else {
      this._wavePercent = 90.0;
    }
    this._rewardPoints = value;
  }

  Future<void> increasePoints(key) async {
    double lastProgress = await _getWaveProgress(key);
    double currentProgress = lastProgress + 10.0;
    setState(() {
      this._rewardPoints = currentProgress;
    });
    if (currentProgress <= 90) {
      setState(() {
        this._wavePercent = currentProgress;
      });
    }
    await _storageService.setDoubleValue('progress', currentProgress);
    await _storageService.setDoubleValue('points', _rewardPoints);
  }

  Future<void> resetCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('progress', 0.0);
    await prefs.setDouble('points', 0.0);
    setState(() {
      this._wavePercent = 0.0;
      this._rewardPoints = 0.0;
    });
  }

//LAYOUT
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(child: Text('Wave percentage value: $_wavePercent')),
          Container(child: Text('Total Reward Points: $_rewardPoints')),
          WaveProgress(250.0, Colors.lightBlueAccent, Colors.lightBlueAccent,
              _wavePercent),
          Container(
            child: RaisedButton(
              child: Text('Log a Float!'),
              textColor: Colors.white,
              color: Colors.lightBlueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              onPressed: () => showAlertDialog(context),
            ),
          ),
          Container(
            child: RaisedButton(
              onPressed: () {
                resetCounter();
              },
              child: Text('Reset'),
              textColor: Colors.white,
              color: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

//ALERT DIALOG & PIN VERIFICATION
  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter Staff PIN"),
          content: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
            onChanged: (value) {
              pinInput = int.parse(value);
            },
          ),
          actions: [
            FlatButton(
              child: Text("Submit"),
              //Code onPressed to validate.
              onPressed: () {
                print(pinInput);
                if (validPin == pinInput) {
                  increasePoints('progress');
                  Navigator.of(context).pop();
                  pinInput = null;
                } else {
                  print('notvalidated');
                }
              },
            ),
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
