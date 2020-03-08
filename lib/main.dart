import 'package:flow_app/rewards.dart';
import 'package:flutter/material.dart';
import 'service_locator.dart';

void main() {
  setupServiceLocator();
  runApp(FlowApp());
}

class FlowApp extends StatefulWidget {
  FlowApp();

  @override
  State<StatefulWidget> createState() {
    return _FlowAppState();
  }
}

class _FlowAppState extends State<FlowApp> {
  int _selectedIndex = 0;
  double rewardsProgress;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _selectedTitle = <Widget>[
    Text(
      'Flow Rewards',
      style: optionStyle,
    ),
    Text(
      'Booking',
      style: optionStyle,
    ),
    Text(
      'Blog',
      style: optionStyle,
    ),
  ];

  static List<Widget> _activePage = <Widget>[
    RewardsWidget(),
    Text(
      'Book A Float',
      style: optionStyle,
    ),
    Text(
      'Blog',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          //title: Text('Flow Spa'),
          title: _selectedTitle.elementAt(_selectedIndex),
          centerTitle: true,
        ),
        body: Center(
          child: _activePage.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              title: Text('Flow Rewards'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              title: Text('Book a Float'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              title: Text('Blog'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
