import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
// This widget is the root
// of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PageView',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        // 'en' is the language code. We could optionally provide a
        // a country code as the second param, e.g.
        // Locale('en', 'US'). If we do that, we may want to
        // provide an additional app_en_US.arb file for
        // region-specific translations.
        const Locale('en', ''),
        const Locale('zh', ''),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _pages = [];
  int _curr = 0;
  PageController controller = PageController();
  AudioCache audioCache = AudioCache();

  Future<void> readJson() async {
    var url = Uri.parse('https://asiaserver.icu/childrensbookapp/stories.json');
    var response = await http.get(url);
    var myPages = json.decode(response.body)[0]["pages"];

    setState(() {
      _pages = myPages;
    });
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await readJson();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
        backgroundColor: Colors.green,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              "Page: " +
                  (_curr + 1).toString() +
                  "/" +
                  _pages.length.toString(),
              textScaleFactor: 2,
            ),
          )
        ],
      ),
      body: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 32, bottom: 32, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 400,
                        width: 400,
                        child: Image.network(
                            'https://asiaserver.icu/childrensbookapp/' +
                                _pages[index]['image']),
                      ),
                      Flexible(
                        child: Column(
                          children: [
                            Text(
                              _pages[index]['text'],
                              //'Note Title',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                              softWrap: false,
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        child: Text('Play'),
                        onPressed: () {
                          audioCache.play(
                              'https://asiaserver.icu/childrensbookapp/' +
                                  _pages[index]['audio']);
                        },
                      ),
                    ],
                  ),
                  //SizedBox(width: 20),
                ],
              ),
            ),
          );
        },
        itemCount: _pages == null ? 0 : _pages.length,
        reverse: false,
        physics: BouncingScrollPhysics(),
        controller: controller,
        onPageChanged: (num) {
          setState(() {
            _curr = num;
          });
        },
      ),
    );
  }
}

class Pages extends StatelessWidget {
  final text;
  Pages({this.text});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ]),
    );
  }
}
