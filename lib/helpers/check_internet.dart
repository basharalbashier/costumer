import 'dart:io';

Future<int> checkInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return 1;
    } else {
      return 0;
    }
  } catch (e) {
    return 0;
  }
}
