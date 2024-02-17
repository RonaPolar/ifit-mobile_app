import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ExerciseVideoWidget extends StatefulWidget {
  const ExerciseVideoWidget({
    required this.urlVideo,
    super.key,
  });

  final String urlVideo;

  @override
  State<ExerciseVideoWidget> createState() => _ExerciseVideoWidgetState();
}

class _ExerciseVideoWidgetState extends State<ExerciseVideoWidget> {

  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true
    ),
  );

  double progress = 0;
  late PullToRefreshController pullToRefreshController;

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      }
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 300,
      child: InAppWebView(
        key: webViewKey,
        initialUrlRequest:
        URLRequest(url: Uri.parse(widget.urlVideo)),
        initialOptions: options,
        pullToRefreshController: pullToRefreshController,
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        // onLoadStart: (controller, url) {
        //   setState(() {
        //     this.url = url.toString();
        //     urlController.text = this.url;
        //   });
        // },
        androidOnPermissionRequest: (controller, origin, resources) async {
          return PermissionRequestResponse(
              resources: resources,
              action: PermissionRequestResponseAction.GRANT);
        },
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          var uri = navigationAction.request.url!;

          // if (![ "http", "https", "file", "chrome",
          //   "data", "javascript", "about"].contains(uri.scheme)) {
          //   if (await canLaunch(url)) {
          //     // Launch the App
          //     await launch(
          //       url,
          //     );
          //     // and cancel the request
          //     return NavigationActionPolicy.CANCEL;
          //   }
          // }

          return NavigationActionPolicy.ALLOW;
        },
        // onLoadStop: (controller, url) async {
        //   pullToRefreshController.endRefreshing();
        //   setState(() {
        //     this.url = url.toString();
        //     urlController.text = this.url;
        //   });
        // },
        onLoadError: (controller, url, code, message) {
          pullToRefreshController.endRefreshing();
        },
        // onProgressChanged: (controller, progress) {
        //   if (progress == 100) {
        //     pullToRefreshController.endRefreshing();
        //   }
        //   setState(() {
        //     this.progress = progress / 100;
        //     urlController.text = this.url;
        //   });
        // },
        // onUpdateVisitedHistory: (controller, url, androidIsReload) {
        //   setState(() {
        //     this.url = url.toString();
        //     urlController.text = this.url;
        //   });
        // },
        onConsoleMessage: (controller, consoleMessage) {
          print(consoleMessage);
        },
      ),
    );
  }
}
