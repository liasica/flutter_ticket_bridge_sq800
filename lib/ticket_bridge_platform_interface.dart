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
  /// @param devPath 串口设备路径
  /// @param baudRate 波特率
  /// @return 串口文件描述符, -1:失败
  Future<int> openPort(String devPath, int baudRate) {
    throw UnimplementedError('devPath() has not been implemented.');
  }

  /// 关闭串口
  /// @param fd 串口文件描述符
  /// @return 0:成功 -1:失败
  Future<int> releasePort(int fd) {
    throw UnimplementedError('releasePort() has not been implemented.');
  }

  /// 切票
  /// @param fd 串口文件描述符
  /// @param addr 出票机机地址
  /// @param type 票长模式 1:英寸 2:毫米
  /// @param size 票长
  /// @param timeout 超时时间
  /// @return 0:成功 1:无票 2:出票口有票 3:切刀错误 4:卡纸
  Future<int> cut(int fd, int addr, int type, int size, int timeout) {
    throw UnimplementedError('cut() has not been implemented.');
  }
}
