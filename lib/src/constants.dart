import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:googleapis_auth/googleapis_auth.dart';

abstract class GoogleTasksAPI {
  static const String linuxClientId =
      '766300722492-1ojenkugmp1abfqlo2ugesvi39fpqqp6.apps.googleusercontent.com';
  static const String linuxClientSecret = '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';

  static ClientId get clientId {
    if (kIsWeb) {
      //
      return ClientId('', '');
    }

    switch (Platform.operatingSystem) {
      case 'linux':
        return ClientId(linuxClientId, linuxClientSecret);
      default:
        return ClientId('', '');
    }
  }
}
