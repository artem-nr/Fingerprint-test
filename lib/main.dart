import 'package:flutter/material.dart';
import 'package:flutter_app/bloc_main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/main_state.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;


  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              return ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text('Finger print'),
                        RaisedButton(
                          child: Text('Auth'),
                          onPressed: () {
                            context.watch<MainBloc>().authenticate();
                          }
                        )
                      ]));
            }
    ),
    ));
  }
}
