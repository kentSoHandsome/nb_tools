import 'dart:convert';

import 'package:encrypt/encrypt.dart';

class AESTools {
  static String decryptString(String str,String aesKey) {
    try {
      final key = Key.fromUtf8(aesKey); //加密key
      final iv = IV.fromLength(0);
      print("beforeString: ${str}");
      final encrypter = Encrypter(AES(key, mode: AESMode.ecb));

      String decrypted = encrypter.decrypt64(
          str.trim().replaceAll("\r", "").replaceAll("\n", ""),
          iv: iv);

      print("decrypt string:${decrypted}");
      return decrypted;
    } catch (error) {
      print("decrypt err:${error}");
      return str;
    }
  }

  static String encryptString(String str,String aesKey) {
    try {
      final key = Key.fromUtf8(aesKey); //加密key
      final encrypter = Encrypter(AES(key, mode: AESMode.ecb));
      final encryptStr = encrypter.encrypt(str);
      print("encrypt strsss:${encryptStr.base64}");
      return encryptStr.base64;
    } catch (error) {
      print("encrypt err:${error}");
      return str;
    }
  }

  static String getLanguageText(String str) {
    try {
      Map<String, dynamic> json = jsonDecode(str);

      return json["original"] ?? (json["zh"] ?? (json.values.first ?? str));
    } catch (error) {
      print("json error:${error}");
      var tempStr = str;
      if (str.startsWith("{\"original\":\"")) {
        tempStr = str.replaceAll("{\"original\":\"", "");
        tempStr = tempStr.replaceAll("\"}", "");
      }
      return tempStr;
    }
  }
}
