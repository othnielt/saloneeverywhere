import 'package:flutter/material.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

class Home extends StatelessWidget {
  File imagePath;

  Home({this.imagePath});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 0.0),
              child: CircleAvatar(
                backgroundColor: Colors.red,
                radius: 30,
                child: ClipOval(
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: imagePath != null
                        ? Image.file(
                            imagePath,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.account_circle_outlined,
                            color: Colors.white,
                            size: 40,
                          ),
                  ),
                ),
              ),
            ),
          ],
          automaticallyImplyLeading: false,
          backgroundColor: Colors.red,
        ),
        body: WebView(
          initialUrl: "https://saloneverywhere.com/sample-profiles",
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
