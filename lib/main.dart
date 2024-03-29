import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.camera.request();
  await Permission.microphone.request();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: InAppWebViewPage());
  }
}

class InAppWebViewPage extends StatefulWidget {
  @override
  _InAppWebViewPageState createState() => new _InAppWebViewPageState();
}

class _InAppWebViewPageState extends State<InAppWebViewPage> {
  InAppWebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: Text("InAppWebView")),
        body: Container(
            child: Column(children: <Widget>[
      Expanded(
        child: Container(
          child: InAppWebView(
              initialUrl:
                  // "https://storage.googleapis.com/tfjs-models/demos/blazeface/index.html",
                  "https://169.254.80.80:3000/camera",
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  mediaPlaybackRequiresUserGesture: true,
                  debuggingEnabled: true,
                ),
              ),
              onWebViewCreated: (InAppWebViewController controller) {
                _webViewController = controller;
              },
              androidOnPermissionRequest: (InAppWebViewController controller,
                  String origin, List<String> resources) async {
                return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT);
              }),
        ),
      ),
    ])));
  }
}
