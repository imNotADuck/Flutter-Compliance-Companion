import 'package:amplify_flutter/amplify_flutter.dart';

class AuthManager {
  static Future<String?> getCurrentUserId() async {
    try {
      final result = await Amplify.Auth.getCurrentUser();
      safePrint("userId from aws: ${result.userId}");
      return result.userId; // or use result.username or result.email
    } on AuthException catch (e) {
      safePrint('Error getting current user: ${e.message}');
      return null;
    }
  }
}
