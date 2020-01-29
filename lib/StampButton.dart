import 'package:flutter/material.dart';
import './PinEntryDialog.dart';

class StampButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StampButtonState();
  }
}

class StampButtonState extends State<StampButton> {
  var currStampColor;
  bool isActiveStamp;

  StampButtonState(
      {this.currStampColor = Colors.grey, this.isActiveStamp = true});

  void stampPressed() {
    currStampColor = Colors.blue;
    this.isActiveStamp = false;
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      //Placeholder for round float button images.
      color: currStampColor,

      child: Text('Float'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
      onPressed: () {
        if (this.isActiveStamp == true) {
          PinEntryDialog().showPinAlertDialog(context);
          setState(() {
            stampPressed();
          });
        }
      },
    );
  }
}
