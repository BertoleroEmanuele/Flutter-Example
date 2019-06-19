import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingPage(),
    );
  }
}

abstract class CounterEvent{}

class IncrementEvent extends CounterEvent{}

class CounterBLoC{

  int _counter = 0;

  final _counterStreamController = StreamController<int>();
  StreamSink<int> get counter_sink => _counterStreamController.sink;

  Stream<int> get stream_counter => _counterStreamController.stream;

  final _counterEventController = StreamController<CounterEvent>();
  Sink <CounterEvent> get counter_event_sink => _counterEventController.sink;

  CounterBLoC() {  _counterEventController.stream.listen(_count);  }


  _count(CounterEvent event) => counter_sink.add(++_counter);

  dispose(){
    _counterStreamController.close();
    _counterEventController.close();
  }
}

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  final _bloc = CounterBLoC();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bloc"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              tooltip: 'Search',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LandingPage2()),
                );
              },
            ),
          ],
        ),
        body: _getBody(),
        floatingActionButton: _getButton()
    );
  }

  @override
  dispose(){
    super.dispose();
    _bloc.dispose();
  }

  _getBody(){
    return StreamBuilder(
        stream: _bloc.stream_counter,
        initialData: 0,
        builder: (context, snapshot) {
          return Center(
            child: Text(snapshot.data.toString()),
          );
        }
    );
  }

  _getButton(){
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => _bloc.counter_event_sink.add(IncrementEvent()),
    );
  }

}

class LandingPage2 extends StatefulWidget {
  @override
  _LandingPageState2 createState() => _LandingPageState2();
}

class _LandingPageState2 extends State<LandingPage2>  {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          tooltip: 'Navigation menu',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Impostazioni"),
      ),
        body: _LandingPageState()._getBody(),
        floatingActionButton: _LandingPageState()._getButton()
    );
  }
}