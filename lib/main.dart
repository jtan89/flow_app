import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import './StampButton.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';

void main() {
  runApp(FlowApp(storage: Storage()));
}

class Storage {
  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/stamps.txt');
  }

  Future<int> readData() async {
    try {
      final file = await localFile;
      String contents = await file.readAsString();
      return int.parse(contents);
    } catch (e) {
      return 0;
    }
  }

  Future<File> writeData(int counter) async {
    final file = await localFile;
    return file.writeAsString('$counter');
  }
}

class FlowApp extends StatefulWidget {
  final Storage storage;
  FlowApp({Key key, @required this.storage}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FlowAppState();
  }
}


class _FlowAppState extends State<FlowApp> {
  int state = 0;
  Future<Directory> _appDocDir;

  @override
  void initState() {
    super.initState();
    widget.storage.readData().then((int value) {
      setState(() {
        state = value;
      });
    });
  }

  //methods to write data to file

  Future<File> writeData() async {
    setState((){
      state += 1;
    });
    return widget.storage.writeData(state);
  }

  void getAppDirectory() {
    setState(() {
      _appDocDir = getApplicationDocumentsDirectory();
    });
  }

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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StampButton(),
                    StampButton(),
                    StampButton(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StampButton(),
                    StampButton(),
                    StampButton(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
            Text('${state ?? "File is Empty"}'),
            RaisedButton(onPressed: writeData, child: Text('Write to File')),
            RaisedButton(onPressed: getAppDirectory, child: Text('Get DIR path')),
            FutureBuilder<Directory>(
              future: _appDocDir,
              builder: (BuildContext context, AsyncSnapshot<Directory> snapshot) {
                Text text = Text('');
                if (snapshot.connectionState == ConnectionState.done) {
                  if(snapshot.hasError) {
                    text = Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    text = Text('path: ${snapshot.data.path}');
                  } else {
                    text = Text('unavailable');
                  }
                }
                return new Container (child: text,);
              },
            )
          ],
        ),
      ),
    );
  }
}


