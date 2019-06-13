import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:sentry/sentry.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,

      ),
      home: FirstRoute(title: 'Segna punti'),
    );
  }
}

class FirstRoute extends StatefulWidget {
  FirstRoute({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _FirstRouteState createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
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
        title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.info),
              tooltip: 'Search',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondRoute()),
                );
              },
            ),
          ],
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

class SecondRoute extends StatelessWidget implements Exception  {
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
        title: Text("Crediti"),
      ),
      body: Center(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Questi sono i crediti"),
              RaisedButton(
                onPressed: _debug,
                child: Text('Non premere'),
              )
            ]
        )
      ),
    );
  }

  final SentryClient sentry = new SentryClient(dsn: "https://1dc1e073142b4acaa9f4bd83508c6834:c9cafdb2f3cc4333b6e654a4e736535b@sentry.io/1480628");

  void _debug() async{
    try {
      debugPrint("Ti avevo avvertito");
      throw new Exception("Ti avevo avvertito");
    } catch(error, stackTrace) {
      await sentry.captureException(
        exception: error,
        stackTrace: stackTrace,
      );
    }
  }
}