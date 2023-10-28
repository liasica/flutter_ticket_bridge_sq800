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

  @override
  Future<List<String>> getAllDevicesPath() async {
    final devices = await methodChannel.invokeMethod('getAllDevicesPath');
    return List<String>.from(devices ?? []);
  }

  @override
  Future<String> getSdkVersion() async {
    return await methodChannel.invokeMethod('getSdkVersion');
  }

  @override
  Future<int> openPort(String devPath, int baudRate) async {
    return await methodChannel.invokeMethod('openPort', {
      'devPath': devPath,
      'baudRate': baudRate,
    });
  }

  @override
  Future<int> releasePort(int fd) async {
    return await methodChannel.invokeMethod('releasePort', {
      'fd': fd,
    });
  }

  @override
  Future<int> cut(int fd, int addr, int type, int size, int timeout) async {
    return await methodChannel.invokeMethod('cut', {
      'fd': fd,
      'addr': addr,
      'type': type,
      'size': size,
      'timeout': timeout,
    });
  }

  @override
  Future<int> getModuleStatus(int fd, int addr, int query) async {
    return await methodChannel.invokeMethod('cut', {
      'fd': fd,
      'addr': addr,
      'query': query,
    });
  }
}
