import 'dart:math';

import 'package:nb_utils/nb_utils.dart';

String randomStringId({int lenght = 12}) {
  var random = Random();

  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  // print(_chars[random.nextInt(_chars.length)]);
  return List.generate(lenght, (index) => _chars[random.nextInt(_chars.length)])
      .join();
}

int randomIntId({int lenght = 12}) {
  var random = Random();

  const _chars = '1234567890';
  print(_chars[random.nextInt(_chars.length)]);
  return List.generate(lenght, (index) => _chars[random.nextInt(_chars.length)])
      .join()
      .toInt();
}
