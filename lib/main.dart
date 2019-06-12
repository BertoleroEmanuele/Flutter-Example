import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(title: 'Segna punti'),
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
  int _rossi = 0;
  int _blu = 0;
  final _match = 15;

  void _segnanoRossi() async{
    setState(() {
        _rossi++;
      if (_rossi == _match) {
        _generateVincitore("ROSSA", _blu);
      }
    });
  }

  void _segnanoBlu() async{
    setState(() {
      _blu++;
      if (_blu == _match) {
        _generateVincitore("BLU", _rossi);
      }
    });
  }

  void _reset() {
    setState(() {
      _rossi=0;
      _blu=0;
    });
  }

  Future _generateVincitore(String squadra, int ptPerdenti) async {

    await showDialog(
        context: context,
        child: new AlertDialog(
            title: Text('Fine partita'),
            content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('HA VINTO LA SQUADRA $squadra !'),
                  Text('Con $_match punti contro i $ptPerdenti punti \'altra squadra.'),
                ]
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Evviva!'),
                onPressed: () {Navigator.of(context).pop();},
              )
            ]
       )
    );
    _reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
      ),
      body:  Center(
        child: Align(
          alignment: Alignment.center,
          child:  Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                  children: <Widget>[
                    Expanded(
                      child:
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                              color: Colors.blueGrey[50],
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                              child: CircleAvatar(
                                                backgroundColor: Colors.red,
                                                child: Text('$_rossi', style: TextStyle(fontSize: 25)),
                                                radius: 31.0,
                                              )
                                          ),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text('Squadra rossa', style: TextStyle(fontSize: 18, color: Colors.grey[700])),
                                          ),
                                        ),
                                      ]
                                  )
                              )
                          )
                      ),
                    ),
                    Expanded(
                      child:
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                              color: Colors.blueGrey[50],
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                              child: CircleAvatar(
                                                backgroundColor: Colors.blue,
                                                child: Text('$_blu', style: TextStyle(fontSize: 25)),
                                                radius: 31.0,
                                              )
                                          ),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text('Squadra blu', style: TextStyle(fontSize: 18, color: Colors.grey[700])),
                                          ),
                                        ),
                                      ]
                                  )
                              )
                          )
                      ),
                    ),
                  ]
              ),
              Row(
                children: <Widget>[
                  const SizedBox(height:33),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child:
                      RaisedButton(
                        child: const Text('Aggiungi pt', style: TextStyle(fontSize: 20, color: Colors.white)),
                        color: Colors.red,
                        onPressed: _segnanoRossi,
                      ),
                    ),
                  ),
                  const SizedBox(height: 33),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child:
                      RaisedButton(
                        child: const Text('Aggiungi pt', style: TextStyle(fontSize: 20, color: Colors.white)),
                        color: Colors.blue,
                        onPressed: _segnanoBlu,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.cached, color: Colors.white,),
        label: Text("Reset", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.grey,
        onPressed: _reset,
      ),
    );
  }
}
