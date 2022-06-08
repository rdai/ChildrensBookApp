class Book {
  late int id;
  late String title;
  late String imageUrl;
  late String pagesUrl;

  Book(this.id, this.title, this.imageUrl, this.pagesUrl);

  Book.fromJson(Map<String, dynamic> json) {
    id:
    (json['id'] != null) ? int.tryParse(json['id'].toString()) : 0;
    title:
    (json['title'] != null) ? json['title'].toString() : 0;
    imageUrl:
    (json['imageUrl'] != null) ? json['imageUrl'].toString() : 0;
    pagesUrl:
    (json['pagesUrl'] != null) ? json['pagesUrl'].toString() : 0;
  }
}
