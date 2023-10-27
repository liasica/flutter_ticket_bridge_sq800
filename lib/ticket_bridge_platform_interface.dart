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

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<List<String>> getAllSerialDevices() {
    throw UnimplementedError('getAllSerialDevices() has not been implemented.');
  }
}
