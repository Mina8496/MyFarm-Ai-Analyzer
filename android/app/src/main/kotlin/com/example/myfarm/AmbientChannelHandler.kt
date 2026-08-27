package com.example.myfarm

import android.app.NotificationManager
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

object AmbientChannelHandler {

    const val AMBIENT_CHANNEL = "myfarm_ambient"

    fun register(activity: FlutterActivity, flutterEngine: FlutterEngine) {
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            AMBIENT_CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "openAmbient" -> {
                    try {
                        val intent = Intent(activity, LockScreenActivity::class.java).apply {
                            addFlags(
                                Intent.FLAG_ACTIVITY_NEW_TASK or
                                    Intent.FLAG_ACTIVITY_CLEAR_TOP or
                                    Intent.FLAG_ACTIVITY_SINGLE_TOP
                            )
                        }
                        activity.startActivity(intent)
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("AMBIENT_OPEN_ERROR", e.message, null)
                    }
                }

                "closeAmbient" -> {
                    try {
                        LockScreenActivity.instance?.finish()
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("AMBIENT_CLOSE_ERROR", e.message, null)
                    }
                }

                "startAmbientService" -> {
                    try {
                        val serviceIntent = Intent(activity, AmbientForegroundService::class.java)
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                            activity.startForegroundService(serviceIntent)
                        } else {
                            activity.startService(serviceIntent)
                        }
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("AMBIENT_SERVICE_ERROR", e.message, null)
                    }
                }

                "stopAmbientService" -> {
                    try {
                        activity.stopService(Intent(activity, AmbientForegroundService::class.java))
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("AMBIENT_SERVICE_ERROR", e.message, null)
                    }
                }

                "requestFullScreenIntentPermission" -> {
                    if (Build.VERSION.SDK_INT >= 34) {
                        val manager = activity.getSystemService(NotificationManager::class.java)
                        if (!manager.canUseFullScreenIntent()) {
                            val intent = Intent(Settings.ACTION_MANAGE_APP_USE_FULL_SCREEN_INTENT).apply {
                                data = Uri.parse("package:${activity.packageName}")
                            }
                            activity.startActivity(intent)
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