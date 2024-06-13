import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../utils/staticmethods.dart';

class apiServices {
  final String url = 'https://lawmakers.co.in/track_master/public/api/';

  Future<dynamic> allApi({token, ctx, type, body, apiname}) async {
    var header = {
      'Content-Type': 'application/json',
    };
    var tokenHeader = {
      "Content-Type": "application/json",
      "responseType": "ResponseType.plain",
      "Authorization": "Bearer $token",
    };
    dynamic result;
    try {
      final response = type == 'post'
          ? await http
              .post(
                Uri.parse(url + apiname),
                body: json.encode(body),
                headers: token != null ? tokenHeader : header,
              )
              .timeout(const Duration(seconds: 500))
          : await http
              .get(
                Uri.parse(url + apiname),
                headers: token != null ? tokenHeader : header,
              )
              .timeout(const Duration(seconds: 500));
      if (response.statusCode == 200) {
        print(response.body);
        try {
          result = json.decode(response.body.toString());
        } catch (_) {
          result = response.body;
        }
      } else if (response.statusCode == 500) {
        STM().errorDialog(ctx,
            'Something went wrong on the server side. Please try again later ${response.statusCode} Occurred in $apiname');
      } else if (response.statusCode == 401) {
        STM().errorDialog(ctx,
            'Something went wrong on the server side. Please try again later ${response.statusCode} Occurred in $apiname');
      } else {
        STM().errorDialog(ctx,
            'Something went wrong on the server side. Please try again later ${response.statusCode} Occurred  in $apiname');
      }
    } catch (e) {
      if (e is TimeoutException) {
        Fluttertoast.showToast(msg: 'TimeOut!!!,Please try again');
      } else if (e is CertificateException) {
        Fluttertoast.showToast(
            msg:
                'CertificateException!!! SSL not verified while fetching data from $apiname');
      } else if (e is HandshakeException) {
        Fluttertoast.showToast(
            msg:
                'HandshakeException!!! Connection not secure while fetching data from $apiname');
      } else if (e is FormatException) {
        Fluttertoast.showToast(
            msg:
                'FormatException!!! Data cannot parse and unexpected format while fetching data from $apiname');
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong in $apiname');
      }
    }
    return result;
  }
}
