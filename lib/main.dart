import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:just_audio/just_audio.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'colors.dart';
// import 'booklist.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override

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
        fontFamily: 'poppins',
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 22,
            backgroundColor: custom2,
          ),
        ),
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
  late AudioPlayer player = AudioPlayer();

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

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await readJson();
      FirebaseAnalytics.instance.logEvent(name: 'readJson');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.appTitle,
          style: TextStyle(fontFamily: 'biscuitkids'),
        ),
        backgroundColor: Theme.of(context).textTheme.headline1!.backgroundColor,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FittedBox(
                  child: Image.network(
                    'https://asiaserver.icu/childrensbookapp/' +
                        _pages[index]['image'],
                    height: 300,
                    width: 300,
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(left: 12, right: 12),
                    scrollDirection: Axis.vertical,
                    // margin: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      _pages[index]['text'],
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                ElevatedButton(
                  child: Text('Play'),
                  onPressed: () async {
                    await player.setUrl(
                        'https://asiaserver.icu/childrensbookapp/' +
                            _pages[index]['audio']);
                    await player.play();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        },
        itemCount: _pages == null ? 0 : _pages.length,
        reverse: false,
        physics: BouncingScrollPhysics(),
        controller: controller,
        onPageChanged: (num) {
          player.stop();
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
