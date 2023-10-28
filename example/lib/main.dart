import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ticket_bridge/ticket_bridge.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  int _fd = 0;
  final _ticketBridgePlugin = TicketBridge();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _ticketBridgePlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Running on: $_platformVersion\n'),
              TextButton(
                onPressed: () async {
                  final result = await _ticketBridgePlugin.getPlatformVersion();
                  print(result);
                },
                child: const Text('getPlatformVersion'),
              ),
              TextButton(
                onPressed: () async {
                  final result = await _ticketBridgePlugin.getAllSerialDevices();
                  print(result);
                },
                child: const Text('getAllSerialDevices'),
              ),
              TextButton(
                onPressed: () async {
                  final result = await _ticketBridgePlugin.getAllDevicesPath();
                  print(result);
                },
                child: const Text('getAllDevicesPath'),
              ),
              TextButton(
                onPressed: () async {
                  final result = await _ticketBridgePlugin.getSdkVersion();
                  print(result);
                },
                child: const Text('getSdkVersion'),
              ),
              TextButton(
                onPressed: () async {
                  final result = await _ticketBridgePlugin.openPort('/dev/ttyS0', baudRate: 9600);
                  print('端口打开结果: result = $result');
                  if (result > -1) {
                    setState(() {
                      _fd = result;
                    });
                  }
                },
                child: const Text('openPort'),
              ),
              TextButton(
                onPressed: () async {
                  final result = await _ticketBridgePlugin.releasePort(_fd);
                  print('释放结果: fd = $_fd, result = $result');
                },
                child: const Text('releasePort'),
              ),
              TextButton(
                onPressed: () async {
                  final result = await _ticketBridgePlugin.cut(_fd, 0, 1, 2, 10);
                  print('切票结果: fd = $_fd, result = $result');
                },
                child: const Text('cut'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
