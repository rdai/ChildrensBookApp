import 'dart:convert';

import 'book.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookList extends StatefulWidget {
  const BookList({Key? key}) : super(key: key);

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  late Future<List<Book>> _books;

  @override
  void initState() {
    super.initState();
    _books = fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Book>>(
        future: _books,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                itemCount: snapshot.data?.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2,
                ),
                itemBuilder: (context, index) {
                  return Text("${snapshot.data?[index].title}");
                });
          } else if (snapshot.hasError) {
            return Text("Error");
          }
          return Text("Loading...");
        },
      ),
    );
  }

  Future<List<Book>> fetchBooks() async {
    var url =
        Uri.parse('https://asiaserver.icu/childrensbookapp/booklist.json');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Book> books = data.map<Book>((book) => Book.fromJson(book)).toList();
      // List<Book> books =          data.map((x) => Book.fromJson(x)).toList();
      // print(books);
      return books;
    } else {
      print('Error!!');
      throw Exception('Failed to Load Post');
    }
  }
}
