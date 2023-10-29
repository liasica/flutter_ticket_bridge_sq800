import 'dart:typed_data';

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
  /// @return >0:串口文件描述符, <0:失败
  Future<int> openPort(String devPath, {baudRate = 9600}) {
    return TicketBridgePlatform.instance.openPort(devPath, baudRate);
  }

  /// 关闭串口
  /// @param fd 串口文件描述符
  /// @return 0:成功 <0:失败
  Future<int> releasePort(int fd) {
    return TicketBridgePlatform.instance.releasePort(fd);
  }

  /// 切票
  /// @param fd 串口文件描述符
  /// @param addr 出票机机地址
  /// @param type 票长模式 1:英寸 2:毫米
  /// @param size 票长
  /// @param timeout 超时时间
  /// @return 0:成功 1:无票 2:出票口有票 3:切刀错误 4:卡纸 <0:通讯错误
  Future<int> cut(int fd, int addr, int type, int size, int timeout) {
    return TicketBridgePlatform.instance.cut(fd, addr, type, size, timeout);
  }

  /// 查询出票模块状态
  /// @param fd 串口文件描述符
  /// @param addr 出票机机地址
  /// @param query 查询类型 1:入票口状态 2:出票口状态 3:切刀状态 4:卡纸状态 5:所有状态
  /// @return <0:通讯错误
  /// @return query=1-4 0:入票口有票或出票口无票或切刀无故障或无卡纸错误 1:入票口无票或出票口有票或发生切刀故障或发生卡纸错误
  /// @return query=5 0:无错误 1:入票口无票 2:出票口有票未取走 3:切刀错误 4:发生卡纸
  Future<int> getModuleStatus(int fd, int addr, int query) async {
    return TicketBridgePlatform.instance.getModuleStatus(fd, addr, query);
  }

  /// 写非易失型设备参数
  /// @param fd 串口文件描述符
  /// @param addr 出票机机地址
  /// @param key 参数键 1:波特率 5:余票数量
  /// @param value 参数值, key=1时为波特率, key=5时为余票数量
  /// @return 0:成功 -100:地址错误 <0:通讯错误
  Future<int> writeConfigData(int fd, int addr, int key, int value) async {
    return TicketBridgePlatform.instance.writeConfigData(fd, addr, key, value);
  }

  /// 读非易失型设备参数
  /// @param fd 串口文件描述符
  /// @param addr 出票机机地址
  /// @param key 参数键, 1:波特率 3:切票总数量 4:走纸里程 5:余票数量 6:固件版本 7:型号
  /// @return 配置值
  /// @return -100:地址错误 <0:通讯错误
  Future<int> readConfigData(int fd, int addr, int key) async {
    return TicketBridgePlatform.instance.readConfigData(fd, addr, key);
  }

  /// 重置刀头
  /// @param fd 串口文件描述符
  /// @param addr 出票机机地址
  /// @return 0:成功 2:重置失败 <0:通讯错误
  Future<int> resetKnife(int fd, int addr) async {
    return TicketBridgePlatform.instance.resetKnife(fd, addr);
  }

  /// 重置卡纸
  /// @param fd 串口文件描述符
  /// @param addr 出票机机地址
  /// @return 0:成功 2:重置失败 <0:通讯错误
  Future<int> resetPaperJam(int fd, int addr) async {
    return TicketBridgePlatform.instance.resetPaperJam(fd, addr);
  }

  /// 发送数据
  /// @param fd 串口文件描述符
  /// @param data 数据
  /// @param len 数据长度
  /// @return >0:发送字节长度 <0:发送失败
  Future<int> writePort(int fd, Uint8List data, int len) async {
    return TicketBridgePlatform.instance.writePort(fd, data, len);
  }

  /// 接收数据
  /// @param fd 串口文件描述符
  /// @param len 数据长度
  /// @return 数据
  Future<Uint8List> readPort(int fd, int len) async {
    return TicketBridgePlatform.instance.readPort(fd, len);
  }

  /// 进退票
  /// @param fd 串口文件描述符
  /// @param addr 出票机机地址
  /// @param direction 方向 1:进票 2:退票
  /// @param size 票长
  /// @param timeout 超时时间(s)
  /// @return 0:成功 6:参数错误 -100:地址错误 <0:通讯错误
  Future<int> feed(int fd, int addr, int direction, int size, int timeout) async {
    return TicketBridgePlatform.instance.feed(fd, addr, direction, size, timeout);
  }

  /// 控制外设
  /// @param fd 串口文件描述符
  /// @param addr 出票机机地址
  /// @param peripheral 外设类型 1:继电器 2:LED
  /// @param duration 通电时间(ms)
  /// @return 0:成功 6:参数错误 -1:控制失败 <0:通讯错误
  Future<int> controlPeripheral(int fd, int addr, int peripheral, int duration) async {
    return TicketBridgePlatform.instance.controlPeripheral(fd, addr, peripheral, duration);
  }
}
