import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/umkm_model.dart';

class UmkmService {
  final String baseUrl = "http://localhost:8080/api/";

  // METHOD GET
  Future<List<Umkm>> getUmkmList() async {
    final response = await http.get(Uri.parse('${baseUrl}umkm'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> data = jsonResponse['data'];
      return data.map((e) => Umkm.fromJson(e)).toList();
    } else {
      throw Exception("Gagal mengambil data UMKM");
    }
  }

  // METHOD POST
  Future<dynamic> createUmkm(Map<String, dynamic> data) async {
    final url = Uri.parse('${baseUrl}umkm');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      },
      body: data,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal menambah data: ${response.body}');
    }
  }
}