import 'package:encrypt/encrypt.dart' show AES, Encrypter, IV, Key;
import 'dart:io';

void main() {
  var plainText = stdin.readLineSync()!;

  final key = Key.fromSecureRandom(
      32); //32 bytes =256 bits (fromSecureRandom:secure random number generator )
  final iv = IV.fromSecureRandom(16); //=128 bits.
  final encrypter = Encrypter(AES(key));

  final encrypted = encrypter.encrypt(plainText, iv: iv); //(iv->name: value)
  final decrypted = encrypter.decrypt(encrypted, iv: iv);

  print(decrypted); //plainText
  print(
      " 'this is bytes:'${encrypted.bytes}"); //In the form of an array of bytes
  print("'this is hex:'${encrypted.base16}"); //hexadecimal
  print(
      "'this is b64:'${encrypted.base64}"); //(base64) A popular format for transferring encrypted data because it is safe to use in URLs
  print("'this is number plain text:'${plainText.length}");
}
