import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ticket_bridge_platform_interface.dart';

/// An implementation of [TicketBridgePlatform] that uses method channels.
class MethodChannelTicketBridge extends TicketBridgePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ticket_bridge');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<List<String>> getAllSerialDevices() async {
    final devices = await methodChannel.invokeMethod('getAllSerialDevices');
    return List<String>.from(devices ?? []);
  }
}
