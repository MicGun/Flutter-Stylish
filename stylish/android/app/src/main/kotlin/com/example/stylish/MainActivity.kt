package com.example.stylish

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.os.Bundle
import android.util.Log
import com.example.test_tappay.PrimeDialog
import tech.cherri.tpdirect.api.*
import tech.cherri.tpdirect.model.TPDTaskListener


class MainActivity: FlutterActivity() {

    private val CHANNEL = "samples.flutter.dev/battery"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        TPDSetup.initInstance(
            applicationContext,
            12348,
            "app_pa1pQcKoY22IlnSXq5m5WP5jFKzoRG58VEXpT7wU62ud7mMbDOGzCYIlzzLF"
            , TPDServerType.Sandbox
        )
        val card = TPDCard.validate(
            StringBuffer("4111111111111111"),
            StringBuffer("06"),
            StringBuffer("24"),
            StringBuffer("123"))
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine.plugins.add(CustomAndroidViewPlugin())
//        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
//            // This method is invoked on the main thread.
//                call, result ->
//            if (call.method == "getBatteryLevel") {
//                val batteryLevel = getBatteryLevel()
//
//                if (batteryLevel != -1) {
//                    result.success(batteryLevel)
//                } else {
//                    result.error("UNAVAILABLE", "Battery level not available.", null)
//                }
//            } else if (call.method == "doTapPay") {
////                Log.d("doTapPay", "configureFlutterEngine: ")
////                val dialog = PrimeDialog(context, object : PrimeDialog.PrimeDialogListener {
////                    override fun onSuccess(prime: String) {
////                        result.success(prime)
////                    }
////
////                    override fun onFailure(error: String) {
////                        result.success(error)
////                    }
////
////                })
////
////                dialog.show(fragmentManager, "TapPay")
////                result.success("call doTapPay")
//            } else {
//                result.notImplemented()
//            }
//        }
    }

    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }

        return batteryLevel
    }

}
