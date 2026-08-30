package com.example.myfarm

import android.app.NotificationManager
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

object AmbientChannelHandler {

    const val AMBIENT_CHANNEL = "myfarm_ambient"

    fun register(context: Context, flutterEngine: FlutterEngine) {
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            AMBIENT_CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "closeAmbient" -> {
                    try {
                        LockScreenActivity.instance?.finish()
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("AMBIENT_CLOSE_ERROR", e.message, null)
                    }
                }

                "openAmbient" -> {
                    result.success(true)
                }

                "startAmbientService" -> {
                    try {
                        val serviceIntent = Intent(context, AmbientForegroundService::class.java)
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                            context.startForegroundService(serviceIntent)
                        } else {
                            context.startService(serviceIntent)
                        }
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("AMBIENT_SERVICE_ERROR", e.message, null)
                    }
                }

                "stopAmbientService" -> {
                    try {
                        context.stopService(Intent(context, AmbientForegroundService::class.java))
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("AMBIENT_SERVICE_ERROR", e.message, null)
                    }
                }

                "requestFullScreenIntentPermission" -> {
                    if (Build.VERSION.SDK_INT >= 34) {
                        val manager = context.getSystemService(NotificationManager::class.java)
                        if (!manager.canUseFullScreenIntent()) {
                            val intent = Intent(Settings.ACTION_MANAGE_APP_USE_FULL_SCREEN_INTENT).apply {
                                data = Uri.parse("package:${context.packageName}")
                                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                            }
                            context.startActivity(intent)
                        }
                    }
                    result.success(true)
                }

                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}