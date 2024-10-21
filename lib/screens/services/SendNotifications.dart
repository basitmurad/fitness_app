import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class SendNotifications {
  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "ridingapp-186e2",
      "private_key_id": "3725eb038e7860fd8ac3ee2e0f979ab286cc22c5",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCcvUCE/G8fHgpt\nEdrW3QDXD9kabU8vi88roaxP7awhBync1kQrJSrhDZJi9FwLZIce2iEdhE6jbPo0\nUqd4TqHr/l+t4ogx1HFifBEFv8AGQ13maVaa39Ww7vzPQAwVu/iFiEqeVAX4bKty\nZFvhPz+EagseLbYh1N0ZNZQgv0NfRqmXz7ssbr5W7kDJDEJ+3XiCt56MNGO3ygjt\nPjlXp+DkwHrNjRE50STHNrIs5zAIEvUnyvJJDN3Iu6RSCEZ7JjThqEEIqy+2KiyM\nZmoAKxz6o7f6/xPRG3MOwRx22/X4VlOEkstL/dhcz0gosC+llIwEo4BNgu+4P082\nI2zx7supAgMBAAECggEAEkWdt+MVsTL3VC+4q0OoTWnzjTkg+hH6XMPEKq0yW8dS\nAgSYfc8faI0Ee7Sw5kMZ3WbgZWh/Il4Z7O+VxlikV7aXwNWfuu9hKHH+KgVohVJl\nJ+8vwW5GoxG5Nw/oWMBJAIga6sowx/0jH3rDm0acSPtzwFjj2p3OCJpOYmLpn7mW\nP7R1n313RM9b8m/JBZluhATLwKkUwdTOt/Nuv5Rcfl3Lk6pqpB0PbIW/nY3yqLnO\nf8RTXWInswsrjnYkcvbGayvjYnNvlFQsVCwPCJJbdfnk+es0vjUd5k58qj6Lp9wX\nCgXPJqml09TC4YJdBX7IqAfyHpyfMxgBSgVil26y4QKBgQDZV9Y9AJU/cS5W86V3\n1EcBn7g+2HxSjSCSZQDyKM3BTLITjDObLIYsoTZkfHp/fZuzZYv47SO3cTCIG7u+\nciEUpwFmNU4KPpxu1AbPAu41YucBLswHAopu77x7lnlKSNZpJQLD7bev6QFgpuks\npW52QPQaNn3HrvYoF2wvEJ6h/wKBgQC4nflQd+A9JVOXNcdySxM+aS+h/6/X+L/2\nPRwU9E9mAMrJUTt+rd9bi/W12twyU+ZCxz6Z3xOZ+I2R1kaJVqZ0EUr1JsVa0cPe\nJO0JAgQ1UdyDvOnp6U94nSDxifYs8fzepErUSVagoQUrHeHeAzzuqrwxmRKiA67e\nrNVg1b5CVwKBgQCM2uEsbblMAWTf002UiE1wXvvANvrzYSUP20euqQUX1kW+Z2l2\nknduaxheLVISV+xVamU5cS5pj4C9ZQPanAqWYNmGTNuDxioJpX24IZURokRFvvdZ\nP6tJ1DLaAZ4fp27Ve7f8FI6sAZzz75hEZ/5bwyKv7kq748cCGpPxOJsmLwKBgQCw\nzjnyopuSc6j2a36zKssnPj1r/B8/yu6suCGov8E6gw+ydaVw0LvURNnwa8XuPQOM\neJyvaECxeKS8QmYTKXUIO3d6CMOBEttuaBbKRbAaEGgLkmTCq7p8XJ8sM2Ab8zSl\nVNqFLCdWdl8ox9mEcb1tJP5O0bZSiwxyHTvNHWa0yQKBgQCDG5fROCDPMymZGn4z\nhwy3zfSvtFG38XO2K/vPt0tQQg7+KBgNwbVo9SawXMMgDHtY+sUmgDfpZBHbftjd\nMEYLwYL07yVN4J7x71AwcUTcIsGSQf/dNnzhpZipYrYOnj9fv55Ys9aYKd0F3Mfa\nrvHUGPdUYBDC2Yzo+rROGGUrcg==\n-----END PRIVATE KEY-----\n",
      "client_email": "firebase-adminsdk-5wf3n@ridingapp-186e2.iam.gserviceaccount.com",
      "client_id": "115872653292679622908",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-5wf3n%40ridingapp-186e2.iam.gserviceaccount.com",
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

