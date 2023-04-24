package com.example.stylish

import android.content.Context
import android.util.Log
import android.view.View
import com.example.test_tappay.PrimeDialog
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView

class CustomViewController(
    private val context: Context,
    messenger: BinaryMessenger,
    val id: Int,
    val params: HashMap<String, Any>
) : PlatformView, MethodChannel.MethodCallHandler {

    private var customView: TapPayNativeView? = null

    private val channel: MethodChannel = MethodChannel(
        messenger, "com.rex.custom.android/customView$id"
    )

    init {
        // 如果需要在自定义view交互中申请监听权限可以加上下面这句话
        // CustomShared.binding?.addRequestPermissionsResultListener(this)

        channel.setMethodCallHandler(this)
        params.entries.forEach {
//            Log.i("rex", "CustomView初始化接收入参：${it.key} - ${it.value}")
        }
    }
    
    override fun getView(): View = initCustomView()

    private fun initCustomView(): View {
        if (customView == null) {
            customView = TapPayNativeView(context, null).apply {
                listener = object : PrimeDialog.PrimeDialogListener {
                    override fun onSuccess(prime: String) {
                        channel.invokeMethod("getPrimeSuccessful", prime)
                    }

                    override fun onFailure(error: String) {
                        channel.invokeMethod("getPrimeFailed", error)
                    }

                }
            }
        }
        return customView!!
    }

    override fun dispose() {
        Log.i("rex", "flutterView on Dispose")
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
//        when (call.method) {
//            "getMessageFromFlutterView" -> {
//                customView?.getMessageFromFlutter(call.arguments.toString())
//                result.success(true)
//            }
//            else -> result.notImplemented()
//        }
    }
}