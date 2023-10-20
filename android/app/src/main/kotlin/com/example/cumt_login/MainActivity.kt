package com.example.cumt_login

import android.content.Context
import android.os.Bundle
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity(): FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        GeneratedPluginRegistrant.registerWith(this)
//        ToastProviderPlugin.register(this, flutterView) //注册Toast插件
    }
}

object ToastProviderPlugin {

    /** Channel名称  **/
    private const val ChannelName = "com.mrper.framework.plugins/toast"

    /**
     * 注册Toast插件
     * @param context 上下文对象
     * @param messenger 数据信息交流对象
     */
    @JvmStatic
    fun register(context: Context, messenger: BinaryMessenger) = MethodChannel(messenger, ChannelName).setMethodCallHandler { methodCall, result ->
        when (methodCall.method) {
            "showShortToast" -> methodCall.argument<String>("message")
                ?.let { showToast(context, it, Toast.LENGTH_SHORT) }
            "showLongToast" -> methodCall.argument<String>("message")
                ?.let { showToast(context, it, Toast.LENGTH_LONG) }
            "showToast" -> methodCall.argument<String>("message")
                ?.let { methodCall.argument<Int>("duration")
                    ?.let { it1 -> showToast(context, it, it1) } }
        }
        result.success(null) //没有返回值，所以直接返回为null
    }

    private fun showToast(context: Context, message: String, duration: Int) = Toast.makeText(context, message, duration).show()

}