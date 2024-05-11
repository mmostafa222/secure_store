import 'package:encrypt/encrypt.dart';
import 'dart:io';

void main() {
  var plainText = stdin.readLineSync()!;

  final key = Key.fromSecureRandom(32);
  final iv = IV.fromSecureRandom(8);
  final encrypter = Encrypter(Salsa20(key));

  final encrypted = encrypter.encrypt(plainText, iv: iv);
  final decrypted = encrypter.decrypt(encrypted, iv: iv);

  print(decrypted);
  print(" 'this is bytes :' ${encrypted.bytes}");
  print(
      "'this is hex:'${encrypted.base16}"); //two hex-digits represent an 8-bit =1byte.
  print(
      "'this is b64:'${encrypted.base64}"); //Base64 adds extra characters to represent data efficiently
  print("'this is number plain text:'${plainText.length}");
}
