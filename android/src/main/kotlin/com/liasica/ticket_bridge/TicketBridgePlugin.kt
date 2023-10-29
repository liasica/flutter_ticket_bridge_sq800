package com.liasica.ticket_bridge

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import com.dingee.tcmsdk.TicketModule


/** TicketBridgePlugin */
class TicketBridgePlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var ticketModule: TicketModule

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "ticket_bridge")
        ticketModule = TicketModule()
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        // https://docs.flutter.dev/platform-integration/platform-channels?tab=type-mappings-kotlin-tab
        when (call.method) {
            "getPlatformVersion" -> getPlatformVersion(result)
            "getAllSerialDevices" -> getAllSerialDevices(result)
            "getAllDevicesPath" -> getAllDevicesPath(result)
            "getSdkVersion" -> getSdkVersion(result)
            "openPort" -> openPort(call, result)
            "releasePort" -> releasePort(call, result)
            "cut" -> cut(call, result)
            "getModuleStatus" -> getModuleStatus(call, result)
            "writeConfigData" -> writeConfigData(call, result)
            "readConfigData" -> readConfigData(call, result)
            "resetKnife" -> resetKnife(call, result)
            "resetPaperJam" -> resetPaperJam(call, result)
            "writePort" -> writePort(call, result)
            "readPort" -> readPort(call, result)
            "feed" -> feed(call, result)
            "ctrlPeripheral" -> ctrlPeripheral(call, result)
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun getPlatformVersion(result: Result) {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
    }

    private fun getAllSerialDevices(result: Result) {
        result.success(ticketModule.allSerialDevices.asList())
    }

    private fun getAllDevicesPath(result: Result) {
        result.success(ticketModule.allDevicesPath.asList())
    }

    private fun getSdkVersion(result: Result) {
        result.success(ticketModule.dgGetSdkVersion())
    }

    private fun openPort(call: MethodCall, result: Result) {
        val devPath = call.argument<String>("devPath")
        val baudRate = call.argument<Int>("baudRate") ?: 9600
        result.success(ticketModule.dgOpenPort(devPath, baudRate))
    }

    private fun releasePort(call: MethodCall, result: Result) {
        val fd = call.argument<Int>("fd") ?: 0
        result.success(ticketModule.dgReleasePort(fd))
    }

    private fun cut(call: MethodCall, result: Result) {
        val args = call.arguments as HashMap<*, *>
        result.success(
            ticketModule.dgCutTicket(
                args["fd"] as Int,
                args["addr"] as Int,
                args["type"] as Int,
                args["size"] as Int,
                args["timeout"] as Int
            )
        )
    }

    private fun getModuleStatus(call: MethodCall, result: Result) {
        val args = call.arguments as HashMap<*, *>
        val fd = args["fd"] as Int
        val addr = args["addr"] as Int
        val query = args["query"] as Int
        result.success(ticketModule.dgGetModuleStatus(fd, addr, query))
    }

    private fun writeConfigData(call: MethodCall, result: Result) {
        val args = call.arguments as HashMap<*, *>
        val fd = args["fd"] as Int
        val addr = args["addr"] as Int
        val key = args["key"] as Int
        val value = args["value"] as Int
        result.success(ticketModule.dgWriteConfigData(fd, addr, key, value))
    }

    private fun readConfigData(call: MethodCall, result: Result) {
        val args = call.arguments as HashMap<*, *>
        val fd = args["fd"] as Int
        val addr = args["addr"] as Int
        val key = args["key"] as Int
        result.success(ticketModule.dgReadConfigData(fd, addr, key, 0))
    }

    private fun resetKnife(call: MethodCall, result: Result) {
        val args = call.arguments as HashMap<*, *>
        val fd = args["fd"] as Int
        val addr = args["addr"] as Int
        result.success(ticketModule.dgResetKnife(fd, addr))
    }

    private fun resetPaperJam(call: MethodCall, result: Result) {
        val args = call.arguments as HashMap<*, *>
        val fd = args["fd"] as Int
        val addr = args["addr"] as Int
        result.success(ticketModule.dgResetPaperJam(fd, addr))
    }

    private fun writePort(call: MethodCall, result: Result) {
        val args = call.arguments as HashMap<*, *>
        val fd = args["fd"] as Int
        val data = args["data"] as ByteArray
        val len = args["len"] as Int
        result.success(ticketModule.dgWritePort(fd, data, len))
    }

    private fun readPort(call: MethodCall, result: Result) {
        val args = call.arguments as HashMap<*, *>
        val fd = args["fd"] as Int
        val len = args["len"] as Int
        result.success(ticketModule.dgReadPort(fd, len))
    }

    private fun feed(call: MethodCall, result: Result) {
        val args = call.arguments as HashMap<*, *>
        val fd = args["fd"] as Int
        val addr = args["addr"] as Int
        val direction = args["direction"] as Int
        val size = args["size"] as Int
        val timeout = args["timeout"] as Int
        result.success(ticketModule.dgFeedTicket(fd, addr, direction, size, timeout))
    }

    private fun controlPeripheral(call: MethodCall, result: Result) {
        val args = call.arguments as HashMap<*, *>
        val fd = args["fd"] as Int
        val addr = args["addr"] as Int
        val peripheral = args["peripheral"] as Int
        val duration = args["duration"] as Int
        result.success(ticketModule.dgCtrlPeripheral(fd, addr, peripheral, duration))
    }
}
