import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/network_response.dart';

Future<String?> GetToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // return prefs.getString("access");
 // return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3Y2ZjZWZmNmZiYjg2MmE2ZDRmYzhjYiIsImZ1bGxOYW1lIjoiYXJpeWFuIiwicGhvbmVOdW1iZXIiOiIwMTk1MjY5MjMzNiIsInByb2ZpbGVJbWFnZSI6bnVsbCwiZW1haWwiOiJhaG1lZGFyaXlhbjM0NkBnbWFpbC5jb20iLCJpc09ubGluZSI6ZmFsc2UsInNvY2tldElkIjpudWxsLCJwYXNzd29yZCI6IiQyYSQxMCR4djhDeTZURS5iajguQjJUdi5mNTV1aGFud3kwV3lyNVUxdThRcE1YR05Yb2pnZWUzLk5NYSIsImlzVmVyaWZ5IjpmYWxzZSwicm9sZSI6IlVTRVIiLCJsb2NhdGlvbiI6bnVsbCwiY291bnRyeSI6bnVsbCwiZ2VuZGVyIjpudWxsLCJzdGF0dXMiOiJBQ1RJVkUiLCJjcmVhdGVkQXQiOiIyMDI1LTAzLTExVDA1OjQ5OjUxLjM1NloiLCJ1cGRhdGVkQXQiOiIyMDI1LTAzLTExVDA1OjQ5OjUxLjM1NloiLCJmY3BtVG9rZW4iOm51bGwsInN0cmlwZUN1c3RvbWVySWQiOiJjdXNfUnZDNW90RkxQbmVwOU8iLCJzdHJpcGVPbmJvYXJkaW5nVXJsIjpudWxsLCJpc09uYm9hcmRpbmdTdWNjZXNzIjpmYWxzZSwiaWF0IjoxNzQxNjcyMjE5LCJleHAiOjE3NDI5NjgyMTl9.g00sl4VPYrZShGMeN71ah49u8UxkwFhOdw6Gjbx8PpA";

  return prefs.getString("userToken");
}

class NetworkCaller {
  //final int timeoutDuration = 10;
  final int timeoutDuration = 80;
  String? token;

  // GET method
  Future<ResponseData> getRequest(String url, {String? token}) async {
    log('GET Request: $url');
    log('GET Token: $token');
    try {
      token = await GetToken();

      final Response response = await get(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Authorization': token ?? '',
        },
      ).timeout(Duration(seconds: timeoutDuration));
      log(response.headers.toString());
      log(response.statusCode.toString());
      log(response.body.toString());
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  // POST method
  Future<ResponseData> postRequest(
    String url, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    log('POST Request: $url');
    log('Request Body: ${jsonEncode(body)}');
    log('Token: $token');
    token = await GetToken();
    try {
      final Response response = await post(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Authorization': token ?? '',
        },
        body: jsonEncode(body),
      ).timeout(Duration(seconds: timeoutDuration));
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> putFormDataWithImage(
    String res,
    String url,
    Map<String, dynamic> body,
    File imageFile,
    String mainKey, {
    String? token,
    String imageName = "galleryImages",
  }) async {
    token = await GetToken();
    if (token == null) {
      log('Token is null, cannot proceed with request.');
      return {'success': false, 'message': 'Token is missing'};
    }

    log('Request token: $token');
    log('Request Body: ${jsonEncode(body)}');

    try {
      var request = http.MultipartRequest(res, Uri.parse(url));
      request.headers.addAll({'Authorization': token});

      String filePath = imageFile.path;
      String? mimeType = lookupMimeType(filePath);

      if (mimeType == null) {
        log('Could not determine MIME type for the file');
        return {'success': false, 'message': 'Invalid file type'};
      }

      request.files.add(
        await http.MultipartFile.fromPath(
          imageName,
          filePath,
          contentType: MediaType.parse(mimeType),
        ),
      );
      request.fields[mainKey] = jsonEncode(body);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      log('Response Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Success',
          'data': jsonDecode(response.body),
        };
      } else {
        return {'success': false, 'message': response.body};
      }
    } catch (e) {
      debugPrint('An error occurred: $e');
      return {'success': false, 'message': 'Exception: $e'};
    }
  }

  Future<ResponseData> putRequest(
    String url, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    log('POST Request: $url');
    log('Request Body: ${jsonEncode(body)}');
    token = await GetToken();
    try {
      final Response response = await put(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Authorization': token ?? '',
        },
        body: jsonEncode(body),
      ).timeout(Duration(seconds: timeoutDuration));
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ResponseData> patchRequest(
    String url, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    log('Patch Request: $url');
    log('Request Body: ${jsonEncode(body)}');
   token = await GetToken();

    debugPrint("token ===========================$token");

    try {
      final Response response = await patch(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Authorization': token ?? '',
        },
       body: jsonEncode(body),
      ).timeout(Duration(seconds: timeoutDuration));
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }
  Future<ResponseData> postWithoutBody(
    String url, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    log('Patch Request: $url');
    log('Request Body: ${jsonEncode(body)}');
   token = await GetToken();

    debugPrint("token ===========================$token");

    try {
      final Response response = await post(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Authorization': token ?? '',
        },
      ).timeout(Duration(seconds: timeoutDuration));
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<bool> sendFormDataWithPhoto(
    String url,
    File imageFile,
  //  String? token,
  ) async {
    token = await GetToken();
    try {
      var request = MultipartRequest('POST', Uri.parse(url));

      request.files.add(await MultipartFile.fromPath('photo', imageFile.path));

      request.headers.addAll({'Authorization': token!});

      var response = await request.send();
      var data = await Response.fromStream(response);
      debugPrint(jsonDecode(data.body)["message"]);
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<String> sendFormDataWithImage(
    String url,
    dynamic body,
    List<dynamic> imageFiles, {
    String? token,
  }) async {
    token = await GetToken();
    log('Request token: $token');

    try {
      var request = MultipartRequest('POST', Uri.parse(url));

      request.fields['bodyData'] = jsonEncode(body);

      for (var imageFile in imageFiles) {
        var multipartFile = await MultipartFile.fromPath(
          'complaintFiles',
          imageFile.path,
        );
        debugPrint(multipartFile.filename);
        request.files.add(multipartFile);
      }

      request.headers.addAll({'Authorization': token!});

      var response = await request.send();
      var data = await Response.fromStream(response);
      if (response.statusCode == 307) {
        return jsonDecode(data.body)["message"];
      }
      debugPrint(jsonDecode(data.body).toString());
      if (response.statusCode == 200) {
        return "Success";
      }
    } catch (e) {
      return '';
    }
    return '';
  }

  // Handle response
  ResponseData _handleResponse(Response response) {
    log('Response Status: ${response.statusCode}');
    log('Response Body: ${response.body}');

    final decodedResponse = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (decodedResponse['success'] == true) {
        return ResponseData(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedResponse['result'],
          errorMessage: '',
        );
      } else {
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decodedResponse,
          errorMessage: decodedResponse['message'] ?? 'Unknown error occurred',
        );
      }
    } else if (response.statusCode == 400) {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: decodedResponse,
        errorMessage: _extractErrorMessages(decodedResponse['errorSources']),
      );
    } else if (response.statusCode == 500) {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: decodedResponse,
        errorMessage:
            decodedResponse['message'] ?? 'An unexpected error occurred!',
      );
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: decodedResponse,
        errorMessage: decodedResponse['message'] ?? 'An unknown error occurred',
      );
    }
  }

  // Extract error messages for status 400
  String _extractErrorMessages(dynamic errorSources) {
    if (errorSources is List) {
      return errorSources
          .map((error) => error['message'] ?? 'Unknown error')
          .join(', ');
    }
    return 'Validation error';
  }

  // Handle errors
  ResponseData _handleError(dynamic error) {
    log('Request Error: $error');

    if (error is ClientException) {
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: '',
        errorMessage: 'Network error occurred. Please check your connection.',
      );
    } else if (error is TimeoutException) {
      return ResponseData(
        isSuccess: false,
        statusCode: 408,
        responseData: '',
        errorMessage: 'Request timeout. Please try again later.',
      );
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: '',
        errorMessage: 'Unexpected error occurred.',
      );
    }
  }

  Future<Response?> getRequestForData(String url, {String? token}) async {
    log('GET Request: $url');
    log('GET Token: $token');
    Response? response;

    token = await GetToken();
    try {
      response = await get(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Authorization': token ?? '',
        },
      ).timeout(Duration(seconds: timeoutDuration));
      final responseDecode = jsonDecode(response.body);
      if (responseDecode['success']) {
        log(response.headers.toString());
        log(response.statusCode.toString());
        log(response.body.toString());
        return response;
      }
    } catch (e) {
      return response;
    }
    return null;
  }
}


//token optional
//eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3Y2ZjZWZmNmZiYjg2MmE2ZDRmYzhjYiIsImZ1bGxOYW1lIjoiYXJpeWFuIiwicGhvbmVOdW1iZXIiOiIwMTk1MjY5MjMzNiIsInByb2ZpbGVJbWFnZSI6bnVsbCwiZW1haWwiOiJhaG1lZGFyaXlhbjM0NkBnbWFpbC5jb20iLCJpc09ubGluZSI6ZmFsc2UsInNvY2tldElkIjpudWxsLCJwYXNzd29yZCI6IiQyYSQxMCR4djhDeTZURS5iajguQjJUdi5mNTV1aGFud3kwV3lyNVUxdThRcE1YR05Yb2pnZWUzLk5NYSIsImlzVmVyaWZ5IjpmYWxzZSwicm9sZSI6IlVTRVIiLCJsb2NhdGlvbiI6bnVsbCwiY291bnRyeSI6bnVsbCwiZ2VuZGVyIjpudWxsLCJzdGF0dXMiOiJBQ1RJVkUiLCJjcmVhdGVkQXQiOiIyMDI1LTAzLTExVDA1OjQ5OjUxLjM1NloiLCJ1cGRhdGVkQXQiOiIyMDI1LTAzLTExVDA1OjQ5OjUxLjM1NloiLCJmY3BtVG9rZW4iOm51bGwsInN0cmlwZUN1c3RvbWVySWQiOiJjdXNfUnZDNW90RkxQbmVwOU8iLCJzdHJpcGVPbmJvYXJkaW5nVXJsIjpudWxsLCJpc09uYm9hcmRpbmdTdWNjZXNzIjpmYWxzZSwiaWF0IjoxNzQxNjcyMjE5LCJleHAiOjE3NDI5NjgyMTl9.g00sl4VPYrZShGMeN71ah49u8UxkwFhOdw6Gjbx8PpA