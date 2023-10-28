import 'ticket_bridge_platform_interface.dart';

class TicketBridge {
  /// 获取平台版本
  Future<String?> getPlatformVersion() {
    return TicketBridgePlatform.instance.getPlatformVersion();
  }

  /// 获取系统中所有串口设备
  Future<List<String>> getAllSerialDevices() {
    return TicketBridgePlatform.instance.getAllSerialDevices();
  }

  /// 获取系统中所有串口设备路径
  Future<List<String>> getAllDevicesPath() {
    return TicketBridgePlatform.instance.getAllDevicesPath();
  }

  /// 获取SDK版本
  Future<String> getSdkVersion() {
    return TicketBridgePlatform.instance.getSdkVersion();
  }

  /// 打开串口
  /// @param devPath 串口设备路径, 如: /dev/ttyS0
  /// @param baudRate 波特率 9600(默认) 19200 38400 57600 115200
  /// @return 串口文件描述符, -1:失败
  Future<int> openPort(String devPath, {baudRate = 9600}) {
    return TicketBridgePlatform.instance.openPort(devPath, baudRate);
  }

  /// 关闭串口
  /// @param fd 串口文件描述符
  /// @return 0:成功 -1:失败
  Future<int> releasePort(int fd) {
    return TicketBridgePlatform.instance.releasePort(fd);
  }

  /// 切票
  /// @param fd 串口文件描述符
  /// @param addr 出票机机地址
  /// @param type 票长模式 1:英寸 2:毫米
  /// @param size 票长
  /// @param timeout 超时时间
  /// @return 0:成功 1:无票 2:出票口有票 3:切刀错误 4:卡纸
  Future<int> cut(int fd, int addr, int type, int size, int timeout) {
    return TicketBridgePlatform.instance.cut(fd, addr, type, size, timeout);
  }
}
