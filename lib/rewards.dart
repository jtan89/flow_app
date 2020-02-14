import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wave_progress_widget/wave_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RewardsWidget extends StatefulWidget {
  RewardsWidget();

  @override
  State<StatefulWidget> createState() {
    return RewardsWidgetState();
  }
}

class RewardsWidgetState extends State<RewardsWidget> {
  RewardsWidgetState();

  double _progress;
  int pinInput;
  int validPin = 12345;

  @override
  void initState() {
    super.initState();
    _getDoubleFromSharedPref().then((value) {
      setState(() {
        _initializeProgress(value);
      });
    });
  }


//SHARED PREFERENCE METHODS 
  Future<double> _getDoubleFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final startNumber = prefs.getDouble('progress');
    if (startNumber == null) {
      return 0.0;
    }
    return startNumber;
  }

  Future<void> _initializeProgress(value) async {
    this._progress = value;
  }

  Future<void> increaseProgress() async {
    final prefs = await SharedPreferences.getInstance();
    double lastProgress = await _getDoubleFromSharedPref();

    double currentProgress = lastProgress + 10.0;
    await prefs.setDouble('progress', currentProgress);

    if (currentProgress < 90) {
      setState(() {
        this._progress = currentProgress;
      });
    }
  }

  Future<void> resetCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('progress', 0);
    setState(() {
      this._progress = 0.0;
    });
  }

//LAYOUT
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(child: Text('$_progress')),
          WaveProgress(
              250.0, Colors.lightBlueAccent, Colors.lightBlueAccent, _progress),
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
                if (pinInput == validPin) {
                  increaseProgress();
                  Navigator.of(context).pop();
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
