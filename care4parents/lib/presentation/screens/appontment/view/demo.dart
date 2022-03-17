import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabBarSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
              ],
            ),
            title: Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              // BlocProvider(
              //   builder: (context) => BlocA(),
              //   child: TabA(),
              // ),
              // BlocProvider(
              //   builder: (context) => BlocB(),
              //   child: TabB(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
