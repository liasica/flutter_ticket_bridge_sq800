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
        val portName = call.argument<String>("portName")
        val baudRate = call.argument<Int>("baudRate") ?: 9600
        result.success(ticketModule.dgOpenPort(portName, baudRate))
    }
    private fun releasePort(call: MethodCall, result: Result) {
        val fd = call.argument<Int>("fd") ?: 0
        result.success(ticketModule.dgReleasePort(fd))
    }

    private fun cut(call: MethodCall, result: Result) {
        
    }
}
