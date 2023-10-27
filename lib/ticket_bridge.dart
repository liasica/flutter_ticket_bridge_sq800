import 'ticket_bridge_platform_interface.dart';

class TicketBridge {
  Future<String?> getPlatformVersion() {
    return TicketBridgePlatform.instance.getPlatformVersion();
  }

  Future<List<String>> getAllSerialDevices() {
    return TicketBridgePlatform.instance.getAllSerialDevices();
  }
}
