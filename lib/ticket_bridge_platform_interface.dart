import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ticket_bridge_method_channel.dart';

abstract class TicketBridgePlatform extends PlatformInterface {
  /// Constructs a TicketBridgePlatform.
  TicketBridgePlatform() : super(token: _token);

  static final Object _token = Object();

  static TicketBridgePlatform _instance = MethodChannelTicketBridge();

  /// The default instance of [TicketBridgePlatform] to use.
  ///
  /// Defaults to [MethodChannelTicketBridge].
  static TicketBridgePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TicketBridgePlatform] when
  /// they register themselves.
  static set instance(TicketBridgePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// 获取平台版本
  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  /// 获取系统中所有串口设备
  Future<List<String>> getAllSerialDevices() {
    throw UnimplementedError('getAllSerialDevices() has not been implemented.');
  }

  /// 获取系统中所有串口设备路径
  Future<List<String>> getAllDevicesPath() {
    throw UnimplementedError('getAllDevicesPath() has not been implemented.');
  }

  /// 获取SDK版本
  Future<String> getSdkVersion() {
    throw UnimplementedError('getSdkVersion() has not been implemented.');
  }

  /// 打开串口
  Future<int> openPort(String devPath, int baudRate) {
    throw UnimplementedError('devPath() has not been implemented.');
  }

  /// 关闭串口
  Future<int> releasePort(int fd) {
    throw UnimplementedError('releasePort() has not been implemented.');
  }

  /// 切票
  Future<int> cut(int fd, int addr, int type, int size, int timeout) {
    throw UnimplementedError('cut() has not been implemented.');
  }

  /// 查询出票模块状态
  Future<int> getModuleStatus(int fd, int addr, int query) {
    throw UnimplementedError('getModuleStatus() has not been implemented.');
  }

  /// 写非易失型设备参数
  Future<int> writeConfigData(int fd, int addr, int key, int value) {
    throw UnimplementedError('writeConfigData() has not been implemented.');
  }

  /// 读非易失型设备参数
  Future<int> readConfigData(int fd, int addr, int key) {
    throw UnimplementedError('readConfigData() has not been implemented.');
  }

  /// 重置刀头
  Future<int> resetKnife(int fd, int addr) {
    throw UnimplementedError('resetKnife() has not been implemented.');
  }

  /// 重置卡纸
  Future<int> resetPaperJam(int fd, int addr) {
    throw UnimplementedError('resetPaperJam() has not been implemented.');
  }

  /// 发送数据
  Future<int> writePort(int fd, Uint8List data, int len) {
    throw UnimplementedError('writePort() has not been implemented.');
  }

  /// 接收数据
  Future<int> readPort(int fd, int len) {
    throw UnimplementedError('readPort() has not been implemented.');
  }

  /// 进退票
  Future<int> feed(int fd, int addr, int direction, int size, int timeout) {
    throw UnimplementedError('feed() has not been implemented.');
  }

  /// 控制外设
  Future<int> ctrlPeripheral(int fd, int addr, int peripheral, int duration) {
    throw UnimplementedError('ctrlPeripheral() has not been implemented.');
  }
}
