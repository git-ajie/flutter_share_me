import 'package:flutter/services.dart';

import 'file_type.dart';

//export file type enum
export 'package:flutter_share_me/file_type.dart';

class FlutterShareMe {
  static const MethodChannel _channel = MethodChannel('flutter_share_me');

  static const String _methodWhatsApp = 'whatsapp_share';
  static const String _methodWhatsAppPersonal = 'whatsapp_personal';
  static const String _methodWhatsAppBusiness = 'whatsapp_business_share';
  static const String _methodFaceBook = 'facebook_share';
  static const String _methodMessenger = 'messenger_share';
  static const String _methodMessengerNew = 'messenger_share_new';
  static const String _methodTwitter = 'twitter_share';
  static const String _methodTwitterNew = 'twitter_share_new';
  static const String _methodInstagramShare = 'instagram_share';
  static const String _methodInstagramShareNew = 'instagram_share_new';
  static const String _methodSystemShare = 'system_share';
  static const String _methodTelegramShare = 'telegram_share';
  static const String _methodLineShare = 'line_share';
  static const String _methodCheckInstalledApps = 'check_installed_apps';

  ///share to WhatsApp
  /// [imagePath] is local image
  /// [phoneNumber] enter phone number with counry code
  /// For ios
  /// If include image then text params will be ingored as there is no current way in IOS share both at the same.
  static Future<String?> shareToWhatsApp(
      {String msg = '', String imagePath = '', FileType? fileType = FileType.image}) async {
    final Map<String, dynamic> arguments = <String, dynamic>{};
    arguments.putIfAbsent('msg', () => msg);
    arguments.putIfAbsent('url', () => imagePath);
    if (fileType == FileType.image) {
      arguments.putIfAbsent('fileType', () => 'image');
    } else {
      arguments.putIfAbsent('fileType', () => 'video');
    }

    String? result;
    try {
      result = await _channel.invokeMethod<String>(_methodWhatsApp, arguments);
    } catch (e) {
      return e.toString();
    }

    return result;
  }

  ///share to WhatsApp
  /// [phoneNumber] phone number with counry code
  /// [msg] message text you want on whatsapp
  static Future<String?> shareWhatsAppPersonalMessage({required String message, required String phoneNumber}) async {
    final Map<String, dynamic> arguments = <String, dynamic>{};
    arguments.putIfAbsent('msg', () => message);
    arguments.putIfAbsent('phoneNumber', () => phoneNumber);

    String? result;
    try {
      result = await _channel.invokeMethod<String>(_methodWhatsAppPersonal, arguments);
    } catch (e) {
      return e.toString();
    }

    return result;
  }

  ///share to Telegram
  /// [msg] message text you want on telegram
  static Future<String?> shareToTelegram({required String msg}) async {
    final Map<String, dynamic> arguments = <String, dynamic>{};
    arguments.putIfAbsent('msg', () => msg);
    String? result;
    try {
      result = await _channel.invokeMethod<String>(_methodTelegramShare, arguments);
    } catch (e) {
      return e.toString();
    }
    return result;
  }

  ///share to WhatsApp4Biz
  ///[imagePath] is local image
  /// For ios
  /// If include image then text params will be ingored as there is no current way in IOS share both at the same.
  static Future<String?> shareToWhatsApp4Biz({String msg = '', String? imagePath = ''}) async {
    final Map<String, dynamic> arguments = <String, dynamic>{};

    arguments.putIfAbsent('msg', () => msg);
    arguments.putIfAbsent('url', () => imagePath);
    String? result;
    try {
      result = await _channel.invokeMethod<String>(_methodWhatsAppBusiness, arguments);
    } catch (e) {
      return 'false';
    }

    return result;
  }

  ///share to facebook
  static Future<String?> shareToFacebook({required String msg, String url = ''}) async {
    final Map<String, dynamic> arguments = <String, dynamic>{};
    arguments.putIfAbsent('msg', () => msg);
    arguments.putIfAbsent('url', () => url);
    String? result;
    try {
      result = await _channel.invokeMethod<String?>(_methodFaceBook, arguments);
    } catch (e) {
      return e.toString();
    }
    return result;
  }

  ///share to messenger
  static Future<String?> shareToMessenger({required String msg, String url = ''}) async {
    final Map<String, dynamic> arguments = <String, dynamic>{};
    arguments.putIfAbsent('msg', () => msg);
    arguments.putIfAbsent('url', () => url);
    String? result;
    try {
      result = await _channel.invokeMethod<String?>(_methodMessenger, arguments);
    } catch (e) {
      return e.toString();
    }
    return result;
  }

  ///share to twitter
  ///[msg] string that you want share.
  static Future<String?> shareToTwitter({required String msg, String url = ''}) async {
    final Map<String, dynamic> arguments = <String, dynamic>{};
    arguments.putIfAbsent('msg', () => msg);
    arguments.putIfAbsent('url', () => url);
    String? result;
    try {
      result = await _channel.invokeMethod(_methodTwitter, arguments);
    } catch (e) {
      return e.toString();
    }
    return result;
  }

  ///use system share ui
  static Future<String?> shareToSystem({required String msg}) async {
    String? result;
    try {
      result = await _channel.invokeMethod<String>(_methodSystemShare, {'msg': msg});
    } catch (e) {
      return 'false';
    }
    return result;
  }

  ///share file to instagram
  static Future<String?> shareToInstagram({required String filePath, FileType fileType = FileType.image}) async {
    final Map<String, dynamic> arguments = <String, dynamic>{};
    arguments.putIfAbsent('url', () => filePath);
    if (fileType == FileType.image) {
      arguments.putIfAbsent('fileType', () => 'image');
    } else {
      arguments.putIfAbsent('fileType', () => 'video');
    }
    String? result;

    try {
      result = await _channel.invokeMethod<String>(_methodInstagramShare, arguments);
    } catch (e) {
      return e.toString();
    }
    return result;
  }

  ///share text to instagram
  static Future<String?> shareToInstagramNew({required String msg}) async {
    final Map<String, dynamic> arguments = <String, dynamic>{};
    arguments.putIfAbsent('msg', () => msg);

    String? result;

    try {
      result = await _channel.invokeMethod<String>(_methodInstagramShareNew, arguments);
    } catch (e) {
      return e.toString();
    }
    return result;
  }

  static Future<String?> shareToTwitterNew({required String msg}) async {
    final Map<String, dynamic> arguments = <String, dynamic>{};
    arguments.putIfAbsent('msg', () => msg);

    String? result;

    try {
      result = await _channel.invokeMethod<String>(_methodTwitterNew, arguments);
    } catch (e) {
      return e.toString();
    }
    return result;
  }

  static Future<String?> shareToMessengerNew({required String msg}) async {
    final Map<String, dynamic> arguments = <String, dynamic>{};
    arguments.putIfAbsent('msg', () => msg);

    String? result;

    try {
      result = await _channel.invokeMethod<String>(_methodMessengerNew, arguments);
    } catch (e) {
      return e.toString();
    }
    return result;
  }

  static Future<String?> shareToLine({required String msg}) async {
    final Map<String, dynamic> arguments = <String, dynamic>{};
    arguments.putIfAbsent('msg', () => msg);

    String? result;

    try {
      result = await _channel.invokeMethod<String>(_methodLineShare, arguments);
    } catch (e) {
      return e.toString();
    }
    return result;
  }

  static Future<Map?> checkInstalledAppsForShare() async {
    final Map? apps = await _channel.invokeMethod(_methodCheckInstalledApps);
    return apps;
  }
}