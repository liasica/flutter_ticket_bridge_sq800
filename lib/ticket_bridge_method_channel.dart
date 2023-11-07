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
    return await methodChannel.invokeMethod('getModuleStatus', {
      'fd': fd,
      'addr': addr,
      'query': query,
    });
  }

  @override
  Future<int> writeConfigData(int fd, int addr, int key, int value) async {
    return await methodChannel.invokeMethod('writeConfigData', {
      'fd': fd,
      'addr': addr,
      'key': key,
      'value': value,
    });
  }

  @override
  Future<int> readConfigData(int fd, int addr, int key) async {
    return await methodChannel.invokeMethod('readConfigData', {
      'fd': fd,
      'addr': addr,
      'key': key,
    });
  }

  @override
  Future<int> resetKnife(int fd, int addr) async {
    return await methodChannel.invokeMethod('resetKnife', {
      'fd': fd,
      'addr': addr,
    });
  }

  @override
  Future<int> resetPaperJam(int fd, int addr) async {
    return await methodChannel.invokeMethod('resetPaperJam', {
      'fd': fd,
      'addr': addr,
    });
  }

  @override
  Future<int> writePort(int fd, Uint8List data, int len) async {
    return await methodChannel.invokeMethod('writePort', {
      'fd': fd,
      'data': data,
      'len': len,
    });
  }

  @override
  Future<Uint8List> readPort(int fd, int len) async {
    return await methodChannel.invokeMethod('readPort', {
      'fd': fd,
      'len': len,
    });
  }

  @override
  Future<int> feed(int fd, int addr, int direction, int size, int timeout) async {
    return await methodChannel.invokeMethod('feed', {
      'fd': fd,
      'addr': addr,
      'direction': direction,
      'size': size,
      'timeout': timeout,
    });
  }

  @override
  Future<int> controlPeripheral(int fd, int addr, int peripheral, int duration) async {
    return await methodChannel.invokeMethod('controlPeripheral', {
      'fd': fd,
      'addr': addr,
      'peripheral': peripheral,
      'duration': duration,
    });
  }
}
