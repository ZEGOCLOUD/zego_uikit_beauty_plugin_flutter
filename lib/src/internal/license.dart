// Dart imports:
import 'dart:convert';
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import '../log/logger_service.dart';

/// ZegoBeautyLicense
class ZegoBeautyLicense {
  static const String licenseKey = 'license_key';
  static const String licenseTimeKey = 'license_time_key';

  /// getEffectsLicense
  static Future<String> getEffectsLicense(int appID, String authInfo) async {
    final prefs = await SharedPreferences.getInstance();
    int lastLicenseTime = prefs.getInt(licenseTimeKey) ?? 0;
    String lastLicense = prefs.get(licenseKey) as String? ?? '';
    if (lastLicense.isNotEmpty &&
        lastLicenseTime > 0 &&
        (currentTime() - lastLicenseTime < 24 * 3600 * 1000)) {
      ZegoBeautyLoggerService.logInfo(
        'last license still valid, lastLicense is valid:${lastLicense.isNotEmpty}, '
        'lastLicenseTime:${DateTime.fromMillisecondsSinceEpoch(1720683703855)}',
        tag: 'beauty',
        subTag: 'license',
      );

      return lastLicense;
    }

    Map<String, dynamic> data = {};
    data = await httpGet(
        'https://aieffects-api.zego.im?Action=DescribeEffectsLicense&AppId=$appID&AuthInfo=$authInfo');

    if (data['Code'] == 0) {
      String license = data['Data']['License'];
      prefs.setString(licenseKey, license);
      prefs.setInt(licenseTimeKey, currentTime());

      ZegoBeautyLoggerService.logInfo(
        'request license done, license:${license.isNotEmpty}',
        tag: 'beauty',
        subTag: 'license',
      );
      return license;
    } else {
      String license = prefs.get(licenseKey) as String? ?? '';
      ZegoBeautyLoggerService.logError(
        'request license errorCode:${data['code']} message:${data['Message']}',
        tag: 'beauty',
        subTag: 'license',
      );
      return license;
    }
  }

  /// httpGet
  static Future<Map<String, dynamic>> httpGet(String url) async {
    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    try {
      final licenseMap = jsonDecode(reply);
      return licenseMap;
    } catch (e) {
      ZegoBeautyLoggerService.logError(
        'license json decode failed reply:$reply',
        tag: 'beauty',
        subTag: 'license',
      );
      debugPrint('JSON decode failed with error: ${e.toString()}');
      return {};
    }
  }

  /// currentTime
  static int currentTime() {
    return DateTime.now().millisecondsSinceEpoch;
  }
}
