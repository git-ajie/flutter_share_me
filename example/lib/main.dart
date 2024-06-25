import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:image_picker/image_picker.dart';

///sharing platform
enum Share {
  facebook,
  twitter,
  whatsapp,
  whatsapp_personal,
  whatsapp_business,
  share_system,
  share_instagram,
  share_telegram,
  share_line,
  check_installed_apps,
  share_messenger,
  share_discord,
  share_snapchat,
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File? file;
  ImagePicker picker = ImagePicker();
  bool videoEnable = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30),
                ElevatedButton(onPressed: pickImage, child: Text('Pick Image')),
                ElevatedButton(onPressed: pickVideo, child: Text('Pick Video')),
                ElevatedButton(onPressed: () => onButtonTap(Share.twitter), child: const Text('share to twitter')),
                ElevatedButton(
                  onPressed: () => onButtonTap(Share.whatsapp),
                  child: const Text('share to WhatsApp'),
                ),
                ElevatedButton(
                  onPressed: () => onButtonTap(Share.whatsapp_business),
                  child: const Text('share to WhatsApp Business'),
                ),
                ElevatedButton(
                  onPressed: () => onButtonTap(Share.whatsapp_personal),
                  child: const Text('share to WhatsApp Personal'),
                ),
                ElevatedButton(
                  onPressed: () => onButtonTap(Share.facebook),
                  child: const Text('share to  FaceBook'),
                ),
                ElevatedButton(
                  onPressed: () => onButtonTap(Share.share_instagram),
                  child: const Text('share to Instagram'),
                ),
                ElevatedButton(
                  onPressed: () => onButtonTap(Share.share_telegram),
                  child: const Text('share to Telegram'),
                ),
                ElevatedButton(
                  onPressed: () => onButtonTap(Share.share_system),
                  child: const Text('share to System'),
                ),
                ElevatedButton(
                  onPressed: () => onButtonTap(Share.share_line),
                  child: const Text('share to Line'),
                ),
                ElevatedButton(
                  onPressed: () => onButtonTap(Share.share_messenger),
                  child: const Text('share to Messenger'),
                ),
                ElevatedButton(
                  onPressed: () => onButtonTap(Share.share_discord),
                  child: const Text('share to Discord'),
                ),
                ElevatedButton(
                  onPressed: () => onButtonTap(Share.share_snapchat),
                  child: const Text('share to Snapchat'),
                ),
                ElevatedButton(
                  onPressed: () => onButtonTap(Share.check_installed_apps),
                  child: const Text('Check Installed Apps'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    final XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
    print(xFile);
    file = File(xFile!.path);
    setState(() {
      videoEnable = false;
    });
  }

  Future<void> pickVideo() async {
    final XFile? xFile = await picker.pickVideo(source: ImageSource.camera);
    print(xFile);
    file = File(xFile!.path);
    setState(() {
      videoEnable = true;
    });
  }

  Future<void> onButtonTap(Share share) async {
    String msg = 'Flutter share is great!!\n Check out full example at https://pub.dev/packages/flutter_share_me';
    String url = 'https://pub.dev/packages/flutter_share_me';

    String? response;
    switch (share) {
      case Share.facebook:
        response = await FlutterShareMe.shareToFacebook(url: url, msg: msg);
        break;
      case Share.twitter:
        response = await FlutterShareMe.shareToTwitter(url: url, msg: msg);
        break;
      case Share.whatsapp:
        if (file != null) {
          response = await FlutterShareMe.shareToWhatsApp(
              imagePath: file!.path, fileType: videoEnable ? FileType.video : FileType.image);
        } else {
          response = await FlutterShareMe.shareToWhatsApp(msg: msg);
        }
        break;
      case Share.whatsapp_business:
        response = await FlutterShareMe.shareToWhatsApp(msg: msg);
        break;
      case Share.share_system:
        response = await FlutterShareMe.shareToSystem(msg: msg);
        break;
      case Share.whatsapp_personal:
        response = await FlutterShareMe.shareWhatsAppPersonalMessage(
            message: msg, phoneNumber: 'phone-number-with-country-code');
        break;
      case Share.share_instagram:
        response = await FlutterShareMe.shareToInstagram(filePath: file!.path);
        break;
      case Share.share_telegram:
        response = await FlutterShareMe.shareToTelegram(msg: msg);
        break;
      case Share.share_line:
        response = await FlutterShareMe.shareToLine(msg: msg);
        break;
      case Share.check_installed_apps:
        final result = await FlutterShareMe.checkInstalledAppsForShare();
        print('installedApps $result');
        break;
      case Share.share_messenger:
        response = await FlutterShareMe.shareToMessengerNew(msg: msg);
        break;
      case Share.share_discord:
        response = await FlutterShareMe.shareToDiscord(msg: msg);
        break;
      case Share.share_snapchat:
        response = await FlutterShareMe.shareToSnapchat(msg: msg);
        break;
    }
    debugPrint(response);
  }
}
