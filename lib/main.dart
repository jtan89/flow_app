import 'package:flutter/material.dart';
import './StampButton.dart';

void main() {
  runApp(FlowApp());
}

class FlowApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FlowAppState();
  }
}

//Create an list of objects or text then output it through StampButton.dart as a raised button using index.


class _FlowAppState extends State<FlowApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flow Spa Loyalty Card'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Float Rewards",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                  "The more you float - the better it gets - and the better you feel. Your 10th float is on us!"),
            ),
         
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                StampButton(),
                StampButton(),
                StampButton(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                StampButton(),
                StampButton(),
                StampButton(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                StampButton(),
                StampButton(),
                StampButton(),
              ],
            ),
              ],
            ),

            Icon(
              Icons.tag_faces,
              color: Colors.blue,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}