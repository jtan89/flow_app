import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RewardsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RewardsWidgetState();
  }
}
class RewardsWidgetState extends State<RewardsWidget> {
   @override
  Widget build(BuildContext context) {
    return RaisedButton(
      //Placeholder for round float button images.
      color: Colors.blue,
      child: Text('Float'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
      onPressed: null,
    );
  }
}