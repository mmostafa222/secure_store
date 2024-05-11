import 'dart:convert'; // Import the dart:convert library
import 'dart:io';
import 'package:simple_rc4/simple_rc4.dart';

void main() {
  RC4 rc4 = RC4('Atef');
  var plainText = stdin.readLineSync()!;
  var bytes = rc4.encodeBytes(
      utf8.encode(plainText)); // Use utf8.encode to encode the input string
  print(bytes);
  print("'this is number plain text:'${plainText.length}");
}
