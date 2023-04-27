package com.example.stylish

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

class CustomAndroidViewPlugin: FlutterPlugin, ActivityAware {
    companion object {
        private const val VIEW_TYPE_ID = "com.rex.custom.android/customView"
    }
    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        binding.platformViewRegistry.registerViewFactory(
            VIEW_TYPE_ID,
            CustomViewFactory(binding.binaryMessenger))
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        
    }

    override fun onDetachedFromActivityForConfigChanges() {
        
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        
    }

    override fun onDetachedFromActivity() {
        
    }
}