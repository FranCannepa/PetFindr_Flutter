import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class Utilities {
  static const int saltLength = 16;

  static String generateSalt() {
    final random = Random.secure();
    final saltBytes =
        List<int>.generate(saltLength, (_) => random.nextInt(256));
    return base64.encode(saltBytes);
  }

  static String hashPassword(String password, String salt) {
    final codec = Utf8Codec();
    final passwordBytes = codec.encode(password);
    final saltBytes = base64.decode(salt);
    final key = Hmac(sha256, saltBytes);
    final hashBytes = key.convert(passwordBytes).bytes;
    return base64.encode(hashBytes);
  }

  static void showErrorMessage(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              Colors.grey[200], // Lighter background for better contrast
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)), // Softer edges
          title: const Text(
            "Oops!", // More casual title for less intimidating error messages
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            errorMessage,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Ok!",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
