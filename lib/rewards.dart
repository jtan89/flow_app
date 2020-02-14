import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wave_progress_widget/wave_progress.dart';

class RewardsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RewardsWidgetState();
  }
}

class RewardsWidgetState extends State<RewardsWidget> {

  var _progress = 10.0;
  int pinInput;
  int validPin = 12345;

//LAYOUT
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(child: Text('content')),
          WaveProgress(
              200.0, Colors.lightBlueAccent, Colors.lightBlueAccent, _progress),
          Container(
            child: RaisedButton(onPressed: () => showAlertDialog(context)),
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
                  setState(() {
                    if (_progress < 100.0) {
                      _progress += 10.0;
                    }
                  });
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
