// Flutter imports:
import 'package:flutter/foundation.dart' show debugPrint, kIsWeb;

// Package imports:
import 'package:flutter_logs/flutter_logs.dart';

/// ZegoBeautyLoggerService
class ZegoBeautyLoggerService {
  static bool isZegoLoggerInit = false;

  /// initLog
  Future<void> initLog({String folderName = 'uikit'}) async {
    if (isZegoLoggerInit) {
      return;
    }

    if (kIsWeb) {
      return;
    }

    try {
      await FlutterLogs.initLogs(
              logLevelsEnabled: [
                LogLevel.INFO,
                LogLevel.WARNING,
                LogLevel.ERROR,
                LogLevel.SEVERE
              ],
              timeStampFormat: TimeStampFormat.TIME_FORMAT_24_FULL,
              directoryStructure: DirectoryStructure.SINGLE_FILE_FOR_DAY,
              logTypesEnabled: ['device', 'network', 'errors'],
              logFileExtension: LogFileExtension.LOG,
              logsWriteDirectoryName: 'zego_prebuilt/$folderName',
              logsExportDirectoryName: 'zego_prebuilt/$folderName/Exported',
              debugFileOperations: true,
              isDebuggable: true)
          .then((value) {
        FlutterLogs.setDebugLevel(0);
        FlutterLogs.logInfo(
          'beauty',
          'log init done',
          '==========================================',
        );
      });

      isZegoLoggerInit = true;
    } catch (e) {
      debugPrint('beauty init logger error:$e');
    }
  }

  /// clearLogs
  Future<void> clearLogs() async {
    FlutterLogs.clearLogs();
  }

  /// logInfo
  static Future<void> logInfo(
    String logMessage, {
    String tag = '',
    String subTag = '',
  }) async {
    if (!isZegoLoggerInit) {
      debugPrint(
          '[INFO] ${DateTime.now().toString()} [$tag] [$subTag] $logMessage');
      return;
    }

    return FlutterLogs.logInfo(tag, subTag, logMessage);
  }

  /// logWarn
  static Future<void> logWarn(
    String logMessage, {
    String tag = '',
    String subTag = '',
  }) async {
    if (!isZegoLoggerInit) {
      debugPrint(
          '[WARN] ${DateTime.now().toString()} [$tag] [$subTag] $logMessage');
      return;
    }

    return FlutterLogs.logWarn(tag, subTag, logMessage);
  }

  /// logError
  static Future<void> logError(
    String logMessage, {
    String tag = '',
    String subTag = '',
  }) async {
    if (!isZegoLoggerInit) {
      debugPrint(
          '[ERROR] ${DateTime.now().toString()} [$tag] [$subTag] $logMessage');
      return;
    }

    return FlutterLogs.logError(tag, subTag, logMessage);
  }

  /// logErrorTrace
  static Future<void> logErrorTrace(
    String logMessage,
    Error e, {
    String tag = '',
    String subTag = '',
  }) async {
    if (!isZegoLoggerInit) {
      debugPrint(
          '[ERROR] ${DateTime.now().toString()} [$tag] [$subTag] $logMessage');
      return;
    }

    return FlutterLogs.logErrorTrace(tag, subTag, logMessage, e);
  }
}
