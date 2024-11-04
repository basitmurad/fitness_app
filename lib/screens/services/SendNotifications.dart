import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class SendNotifications {
  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "socialfitnessapp-5ac05",
      "private_key_id": "56916960b0e16533c3914588fa1b79840572cc7e",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCsEga6h9oSFJm3\nxVdP/UrFvgeo7MXJtIGdOfM/Og0KCguflvb9fvnR7/Uct0FAyrtc6ZKqBdyrOxjw\nPfXbaRkkGxAV1/uQrOhfUbR7ptXqEWoVXwVZTeQOQUCblu4O0TiCbjbuP7iksIOR\nMyGfITeYnbRMN7xEwxuFNW71dPeswqY60TLQG1wxDHlLs5nCp6/bs2ekkju/2UUm\nTaQD9nXgkEbLAUqYXFLu+m1rR3LqFKLcoKwxPndOnySrbzTGG998Fm6UOHTELVdG\ntRwn0ENMxjMYCiRAPmjkAcg1pjsKY3ePZsmcPE0o4Fn1b2VvsVzIZ49Z07t4YmD4\noGU+zAZNAgMBAAECggEADw0nSDBoo5A9v1TPGxDIS50gb7xWXhsgrgTLAaAtp8/S\neHaXdaZ3v89s8hgYPcyosFXrcwfpkj4sePH9NuDDRuSUdvSvmADSoBPg5Q1mRNVF\nIZ1wNaxEjff96MjpBflzJ1BGFHe/ylgjtL3I68csungrtJxjfDhSM0gbQ/P5U5kx\nJ57ZLuwo4pzPgXdaRsXts3rY6gMHvdO/am7Cs/AWWHVRICYPKDcpp4co/HOqI/hq\nZTJm9dQK7+8xTyTs/YkalO8XUk0jVK+T2dmaYgL5PmI4n4TkvPRIjM9S+OFBJRRh\nFkw5GVoXwnJS/F2PHV3t0fA9rNRhd2r7dwFO+GyamQKBgQDKpaPmalpY3LzF0PFr\nBDMxVxkfkymJ1BHV2zn+rL1Z+XAo4hjQp1If93hIuZKJvde5JfgWy91IX/qIjftb\ng9EVood3k4ASotrAQgCxJffLhloYS4s6iAjYzYM1PECkgLuFtp5PFqDQRKXZjJPD\nuxruFBSDyNfBf7m4KlEpH6PyawKBgQDZX4eWY25v5iwt2vgy0SRcCjhCE1EZAlaj\nBuxbawuEX9TvIkDlq5HuMemLZC8YDGrzw3vj832rb2V4QX6epjL3bWpV0gx5CCfI\n/+BhFLgj4S4yHvuU/5WBv79lJc4Nk57qq+teBTY3ly18vytSYlfzKTtlAocsBnPW\nDuhZAuxIJwKBgF9MbjuZoEtR42ST0jSlkP2PHD2BE3PBy3Fq22ctDQ8XAuv3B/x3\n82MdGe/5dTRZlu13MahmzvWOTV+ShbaP0u/9sv9E2mHpPD5Vy8WDOXj5Ab2TKTKp\nbp+mZiHO6Ad0krtbGi/PUGkhH22jcooFn7B+uPcQqIZS7p/xJqHUQ2FpAoGAVfwX\n4kFKujDOYQUxEMjyHQZd4qVJex8Vrj9a136se5x82msuSKtpelN8Eot6pYSj+fDl\n3PHAUEQsWzltIMyVdJJvcas5C9dSBYxR8ZUEkgzM/T6MPhArz7tNtnER5QTz49hF\nrldZbvv6HlJwjJIiQCmbOQWa+qtCvvX+qtchKBkCgYEAukzjzh1AZRpsMb1lqjc4\nz6r6DRfdrL/zUK5KQ7+l4BmgoWFQK4SYsc+HFjPYBvgy54D6jwlMrwiwjk1BmYwr\ngHHlgtBbtrfNQYnsbmCRf6DhO5WRGntR2wz8Uwx4qLDGr62Ymk2bhftdxdGlULvw\ncsctm8/nZbBsn3kYshEz2j8=\n-----END PRIVATE KEY-----\n",
      "client_email": "firebase-adminsdk-mxprz@socialfitnessapp-5ac05.iam.gserviceaccount.com",
      "client_id": "102269895426527445546",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-mxprz%40socialfitnessapp-5ac05.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging",
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    auth.AccessCredentials credentials =
    await auth.obtainAccessCredentialsViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
      client,
    );

    client.close();
    return credentials.accessToken.data;
  }

  static sendNotificationToSelectedDriver(
      String token, BuildContext context, String tripId , String from , String to) async {

    final String serverToken = await getAccessToken();

    String endPoint =
        "https://fcm.googleapis.com/v1/projects/ridingapp-186e2/messages:send";

    final Map<String, dynamic> messages = {
      'message': {
        'token': token,
        'notification': {
          'title': "Booking",
          'body': "Picked up location $from and Drop of location $to",
        },
        'data': {
          'tripId': tripId,
        }
      }
    };

    final http.Response response = await http.post(
      Uri.parse(endPoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverToken',
      },
      body: jsonEncode(messages),
    );

    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      print("Notification sent successfully");
      Fluttertoast.showToast(msg: "Notification sent ${response.body}");
    } else {
      print("Failed to send FCM: ${response.statusCode}");
      print("Response Body: ${response.body}");
      Fluttertoast.showToast(msg: "Failed to send notification ${response.body}");
    }
  }
}

