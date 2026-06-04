import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:unitask/app/api_strings.dart';
import 'package:unitask/core/models/result.dart';
import 'package:unitask/core/models/subject.dart';

class SubjectApiService {
  final String _baseUrl = '${AppStrings.apiHostUrl}/subjects';

  Map<String, String> _headers(String accessToken) => {
    HttpHeaders.authorizationHeader: 'Bearer $accessToken',
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  //GET /subjects => 목록조회
  Future<Result<List<Subject>>> fetchAll(String accessToken) async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: _headers(accessToken),
      );

      if (response.statusCode != 200) {
        throw Exception('과목 목록을 불러오지 못했습니다.');
      }

      final list = (json.decode(response.body) as List)
          .map((e) => Subject.fromMap(e as Map<String, dynamic>))
          .toList();

      return Success(list);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<Subject>> create({
    required String accessToken,
    required String name,
    String? color,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: _headers(accessToken),
        body: jsonEncode({'name': name, 'color': ?color}),
      );

      if (response.statusCode != 200) {
        return Failure(Exception('과목 생성을 실패했습니다.'));
      }

      return Success(
        Subject.fromMap(jsonDecode(response.body) as Map<String, dynamic>),
      );
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }
}
