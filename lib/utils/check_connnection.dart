import 'dart:io';
import 'package:flutter_rabin_karp_algorithm_app/utils/global_config.dart';

class CheckConnection {
  ///this function aims to execute the connection-checking of the user
  ///
  ///@return [bool] :
  ///- 'true' if the internet connection is exist
  ///- 'false if there is no internet connection
  ///
  ///created on January 18th, 2025
  static Future<bool> execute() async {
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup(GlobalConfig.GOOGLE_DOMAIN);
      if (result.isNotEmpty) {
        final HttpClientRequest response =
            await HttpClient().getUrl(Uri.parse("https://www.google.com/"));
        final HttpClientResponse httpResponse = await response.close();
        if (httpResponse.statusCode == 200) {
          return true;
        }
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}
