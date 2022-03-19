import 'dart:math';

class CustomUUID {
  static String generateUUID([int length = 9]) {
    final _random = Random();
    const _availableChars = 'abcdefghijklmnopqrstuvwxyz';
    String randomString = List.generate(length,
            (index) => _availableChars[_random.nextInt(_availableChars.length)])
        .join();

    late String finalString;
    finalString =
        randomString.substring(0, 3) + '-' + randomString.substring(3);
    finalString = finalString.substring(0, 7) + '-' + finalString.substring(7);
    return finalString;
  }
}
