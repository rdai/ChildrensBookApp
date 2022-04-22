import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';

void main() async{

  runApp(MyApp());
}

class MyApp extends StatelessWidget {


// This widget is the root
// of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PageView',
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


  // myMap.forEach((page) {
  //   page.forEach((key, value) {
  //     print(key);
  //     print(value);
  //     // (value).forEach((key2, value2) {
  //     //   print(key2);
  //     //   print(value2);
  //     // });
  //   });
  // });


  // print('Response status: ${response.statusCode}');
  // print('Response body: ${response.body}');

  // Fetch content from the json file



  // print(myPages.length);
  // print ('may: ${myMap}');

  // final myPageList = <Widget>[];
  // for (var i = 0; i < myPages.length; i++) {
  // myPageList.add(new Center(child:new Pages(text: myPages[i].text,)));
  // }


  PageController controller=PageController();
  // List<Widget> _list= myPageList;
  // <Widget>[
  //   new Center(child:new Pages(text: "Page 1",)),
  //   new Center(child:new Pages(text: "Page 2",)),
  //   new Center(child:new Pages(text: "Page 3",)),
  //   new Center(child:new Pages(text: "Page 4",))
  // ];
  int _curr=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar:AppBar(
          title: Text("Beeblios"),
          backgroundColor: Colors.green,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                "Page: "+(
                    _curr+1).toString()+"/"+_pages.length.toString(),textScaleFactor: 2,),
            )
          ],),
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
                          height: 500,
                          width: 500,
                          child: Image.network('https://asiaserver.icu/childrensbookapp/' + _pages[index]['image']),
                        ),

                        InkWell(
                          // onTap: () {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (_) => Welcome()));
                          // },
                          child: Text(
                            _pages[index]['text'],
                            //'Note Title',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                        ),

                        TextButton(
                          child: Text('Play'),
                          onPressed: (){
                            audioCache.play('https://asiaserver.icu/childrensbookapp/' + _pages[index]['audio']);
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
          onPageChanged: (num){

            setState(() {
              _curr=num;
            });
          },
        ),
        // floatingActionButton:Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children:<Widget>[
        //       FloatingActionButton(
        //           onPressed: () {
        //             setState(() {
        //               _list.add(
        //                 new Center(child: new Text(
        //                     "New page", style: new TextStyle(fontSize: 35.0))),
        //               );
        //             });
        //             if(_curr!=_list.length-1)
        //               controller.jumpToPage(_curr+1);
        //             else
        //               controller.jumpToPage(0);
        //           },
        //           child:Icon(Icons.add)),
        //       FloatingActionButton(
        //           onPressed: (){
        //             _list.removeAt(_curr);
        //             setState(() {
        //               controller.jumpToPage(_curr-1);
        //             });
        //           },
        //           child:Icon(Icons.delete)),
        //     ]
        // )
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
          children:<Widget>[
            Text(text,textAlign: TextAlign.center,style: TextStyle(
                fontSize: 30,fontWeight:FontWeight.bold),),
          ]
      ),
    );
  }
}
