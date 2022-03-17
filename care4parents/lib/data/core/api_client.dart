import 'dart:convert';

import 'package:http/http.dart';

import 'api_constants.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;

class ApiClient {
  final Client _client;

  ApiClient(this._client);

  dynamic get(String path, String token, {Map<String, dynamic> params}) async {
    print(
      path,
    );
    final response = await _client.get(
      params != null ? Uri.parse(getPath(path, params)) : Uri.parse('${ApiConstants.BASE_URL}$path'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token != null ? 'Bearer ${token}' : null
      },
    );
    print('response >>>>>>>>>>' + response.body.toString());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic getDirect(String path) async {
    final response = await _client.get(Uri.parse(path));
    print('response >>>>>>>>>>' + response.body.toString());
    // if (response.statusCode == 200) {
    return json.decode(response.body);
    // } else {
    //   throw Exception(response.reasonPhrase);
    // }
  }

  dynamic post(String path, Map<String, dynamic> body, [token]) async {
    print('${ApiConstants.BASE_URL}$path');
    print('body' + json.encode(body));
    final response = await _client.post(Uri.parse('${ApiConstants.BASE_URL}$path'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token != null ? 'Bearer ${token}' : null
        },
        body: json.encode(body));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(response.body);
      return json.decode(response.body);
    }
  }

  dynamic donkeypost(String path, Map<String, dynamic> body, [token]) async {
    print('${ApiConstants.BASE_URL}$path');
    print('body' + json.encode(body));
    final response = await _client.post(Uri.parse('${ApiConstants.BASE_URL}$path'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token != null ? 'Bearer ${token}' : null
        },
        body: json.encode(body));
    print(response.statusCode);
    if (response.statusCode == 400) {
      return json.decode(response.body);
    } else {
      print(response.reasonPhrase);
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic put(String path, String token, Map<String, dynamic> body,
      [Map<String, String> params]) async {
    print('body' + body.toString() + getPutPath(path, params));
    final response = await _client.put(Uri.parse(getPutPath(path, params)),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token}'
        },
        body: json.encode(body));
    print('response >>>>>>>>>>' + response.body.toString());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  String getPath(String path, Map<String, dynamic> params) {
    var paramsString = '';
    if (params?.isNotEmpty ?? false) {
      params.forEach((key, value) {
        paramsString += '$key=$value';
      });
    }
    // first param handled only
    var url = '${ApiConstants.BASE_URL}$path' + '?' + '$paramsString';
    print('url >>>>>>' + url);
    return url;
  }

  String getPutPath(String path, Map<dynamic, dynamic> params) {
    var paramsString = '';
    if (params?.isNotEmpty ?? false) {
      params.forEach((key, value) {
        paramsString += '/$value';
      });
    }
    return '${ApiConstants.BASE_URL}$path$paramsString';
  }

  dynamic postMultiPart(String path, String url, [token]) async {
    try {
      var dioRequest = dio.Dio();
      dioRequest.options.baseUrl = '${ApiConstants.BASE_URL}';
      dioRequest.options.headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': token != null ? 'Bearer ${token}' : null
      };
      var formData = new dio.FormData.fromMap({});

      var file = await dio.MultipartFile.fromFile(url);

      formData.files.add(MapEntry('file', file));
      var response = await dioRequest.post(
        path,
        data: formData,
      );
      print('response' + response.toString());
      if (response.statusCode == 200) {
        return json.decode(response.toString());
      } else {
        print(response.statusMessage);
        throw Exception(response.statusMessage);
      }
    } catch (err) {
      print('ERROR  $err');
    }
  }

  dynamic postMultiPartData(String path, String url,
      [token, family_member_id]) async {
    // try {
    print('family_member_id' + family_member_id);
    //   print('token' + token);
    //   print('url' + url);
    //   var dioRequest = dio.Dio();
    //   dioRequest.options.baseUrl = '${ApiConstants.BASE_URL}';
    //   dioRequest.options.headers = {
    //     'Content-Type': 'multipart/form-data',
    //     'Authorization': token != null ? 'Bearer ${token}' : null
    //   };
    //   var formData = new dio.FormData.fromMap({});
    //   formData.fields.add(MapEntry('family_member', family_member_id));
    //   var file = await dio.MultipartFile.fromFile(url);

    //   formData.files.add(MapEntry('file', file));
    //   print(formData);
    //   var response = await dioRequest.post(
    //     path,
    //     data: formData,
    //   );
    //   print('response' + response.toString());
    //   if (response.statusCode == 200) {
    //     return json.decode(response.toString());
    //   } else {
    //     print(response.statusMessage);
    //     throw Exception(response.statusMessage);
    //   }
    // } catch (err) {
    //   print('ERROR  $err');
    // }
    var headers = {'Authorization': 'Bearer ${token}'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiConstants.BASE_URL}document/strapi-upload'));
    request.fields.addAll({'family_member': family_member_id});
    request.files.add(await http.MultipartFile.fromPath('document', url));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      // String res = await response.stream.bytesToString();
      String res;
      await response.stream.bytesToString().then((value) {
        print(value);
        res = value;
      });
      return res;
      // }
    } else {
      print(response.reasonPhrase);
    }
  }

  dynamic rozarOrder(
      String path, Map<String, String> body, username, password) async {
    // print('$path');
    // print('body' + json.encode(body));
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    // print(basicAuth);

    // final response = await _client.post('$path',
    //     headers: {
    //       'Content-Type': 'application/json',
    //       'Authorization': basicAuth != null ? basicAuth : null
    //     },
    //     body: json.encode(body));
    // print(response.body);
    // if (response.statusCode == 200) {
    //   return json.decode(response.body);
    // } else {
    //   print(response.reasonPhrase);
    //   throw Exception(response.reasonPhrase);
    // }
    var headers = {
      'Authorization':
          'Basic cnpwX2xpdmVfTnppeTdQZndPYklIbVY6UmdYTWRkOE8wSGZ0VVJ4QklqZlFocTV0',
      'Content-Type': 'multipart/form-data'
    };
    try {
      var dioRequest = dio.Dio();
      dioRequest.options.headers = headers;
      var formData = new dio.FormData.fromMap(body);
      print(formData);
      var response = await dioRequest.post(
        path,
        data: formData,
      );
      print(response.statusCode);
      print(response.statusMessage);
      if (response.statusCode == 200) {
        return json.decode(response.toString());
      } else {
        print(response.statusMessage);
        throw Exception(response.statusMessage);
      }
    } catch (err) {
      print('ERROR  $err');
    }
  }
}
