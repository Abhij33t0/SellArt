class Painting {
  final String image;
  final String paintingName;
  final String authorName;
  final String price;

  Painting({
    required this.image,
    required this.paintingName,
    required this.authorName,
    required this.price,
  });

  factory Painting.fromJson(Map<String, dynamic> json) {
    return Painting(
      image: json['image'],
      paintingName: json['paintingname'],
      authorName: json['authorname'],
      price: json['price'],
    );
  }
}
