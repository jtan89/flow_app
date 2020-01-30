import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class StampButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StampButtonState();
  }
}

class StampButtonState extends State<StampButton> {

  var currStampColor;
  bool isActiveStamp;
  int pinInput;
  int validPin = 12345;
 

  StampButtonState(
      {this.currStampColor = Colors.grey, this.isActiveStamp = true});

  void validate() {
    this.currStampColor = Colors.blue;
    this.isActiveStamp = false;
  }

  void _showDialog() {
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
                    validate();
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

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      //Placeholder for round float button images.
      color: currStampColor,
      child: Text('Float'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
      onPressed: () {
        if(this.isActiveStamp == true) {
          _showDialog();
        }
      },
    );
  }
}
