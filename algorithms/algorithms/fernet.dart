import 'package:encrypt/encrypt.dart';
import 'dart:convert';
import 'dart:io';

void main() {
  // Plain text to encrypt
  var plainText = stdin.readLineSync()!;

  // Key generation with base64 encoding
  final key = Key.fromUtf8('my32lengthsupersecretnooneknows1');
  final b64key = Key.fromUtf8(base64Url.encode(key.bytes).substring(0, 32));

  // Fernet instance with key
  final fernet = Fernet(b64key);
  final encrypter = Encrypter(fernet);

  // Encryption and decryption
  final encrypted = encrypter.encrypt(plainText);
  final decrypted = encrypter.decrypt(encrypted);

  // Output
  print(decrypted);
  print(encrypted.base64);
  print(fernet.extractTimestamp(encrypted.bytes));
  print("'this is number plain text:'${plainText.length}");
}
