import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinEntryDialog {
  
  void showPinAlertDialog(BuildContext context) {
    
    var alert = AlertDialog(
      title: Text("Enter Staff PIN"),
      content: TextField(
        keyboardType: TextInputType.number,
        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      ),
      actions: [
         FlatButton(
          child: Text("Submit"),
          //Code onPressed to validate.
          onPressed: (){},
        ),
        FlatButton(
          child: Text("Close"),
          onPressed: () { Navigator.of(context).pop(); },
        )
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
 }