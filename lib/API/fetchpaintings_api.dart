import 'dart:convert';
import 'package:http/http.dart' as http;
import '../ApiModel/fetchpaintingsmodel.dart';

Future<List<Painting>> fetchPaintings() async {
  final response = await http.get(Uri.parse('http://192.168.5.136/flutterApp/fetch_paintings.php'));

  if (response.statusCode == 200) {
    final List<dynamic> paintingsJson = json.decode(response.body)['paintings'];
    return paintingsJson.map((json) => Painting.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load paintings');
  }
}
