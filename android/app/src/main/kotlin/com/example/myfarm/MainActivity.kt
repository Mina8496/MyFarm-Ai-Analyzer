package com.example.myfarm

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.PowerManager
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "myfarm_alarm"

    override fun configureFlutterEngine(
        flutterEngine: FlutterEngine
    ) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->

            when (call.method) {

                "scheduleAlarm" -> {

                    val id = call.argument<Int>("id") ?: 1001
                    val timestamp = call.argument<Long>("timestamp") ?: 0L
                    val hour = call.argument<Int>("hour") ?: 0
                    val minute = call.argument<Int>("minute") ?: 0

                    try {
                        scheduleAlarm(id, timestamp)
                        saveAlarmToPrefs(id, hour, minute)
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("SCHEDULE_ERROR", e.message, null)
                    }
                }

                "cancelAlarm" -> {

                    val id = call.argument<Int>("id") ?: 1001

                    try {
                        cancelAlarm(id)
                        removeAlarmFromPrefs(id)
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("CANCEL_ERROR", e.message, null)
                    }
                }

                "canScheduleExactAlarms" -> {
                    result.success(canScheduleExactAlarms())
                }

                "requestOverlayPermission" -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M &&
                        !Settings.canDrawOverlays(this)
                    ) {
                        val intent = Intent(
                            Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
                            Uri.parse("package:$packageName")
                        )
                        startActivity(intent)
                    }
                    result.success(true)
                }

                "hasOverlayPermission" -> {
                    val granted = Build.VERSION.SDK_INT < Build.VERSION_CODES.M ||
                        Settings.canDrawOverlays(this)
                    result.success(granted)
                }

                "requestIgnoreBatteryOptimization" -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                        val pm = getSystemService(Context.POWER_SERVICE) as PowerManager
                        if (!pm.isIgnoringBatteryOptimizations(packageName)) {
                            val intent = Intent(
                                Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS,
                                Uri.parse("package:$packageName")
                            )
                            startActivity(intent)
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

    private fun scheduleAlarm(id: Int, timestamp: Long) {

        val alarmManager =
            getSystemService(Context.ALARM_SERVICE) as AlarmManager

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            if (!alarmManager.canScheduleExactAlarms()) {
                throw IllegalStateException(
                    "Exact alarm permission is not granted"
                )
            }
        }

        val intent = Intent(this, AlarmReceiver::class.java).apply {
            putExtra("alarm_id", id)
        }

        val pendingIntent = PendingIntent.getBroadcast(
            this,
            id,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or
                PendingIntent.FLAG_IMMUTABLE
        )

        alarmManager.setExactAndAllowWhileIdle(
            AlarmManager.RTC_WAKEUP,
            timestamp,
            pendingIntent
        )
    }

    private fun cancelAlarm(id: Int) {

        val alarmManager =
            getSystemService(Context.ALARM_SERVICE) as AlarmManager

        val intent = Intent(this, AlarmReceiver::class.java)

        val pendingIntent = PendingIntent.getBroadcast(
            this,
            id,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or
                PendingIntent.FLAG_IMMUTABLE
        )

        alarmManager.cancel(pendingIntent)
        pendingIntent.cancel()
    }

    private fun canScheduleExactAlarms(): Boolean {

        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) {
            return true
        }

        val alarmManager =
            getSystemService(Context.ALARM_SERVICE) as AlarmManager

        return alarmManager.canScheduleExactAlarms()
    }

    private fun saveAlarmToPrefs(id: Int, hour: Int, minute: Int) {
        val prefs = getSharedPreferences("myfarm_alarms", Context.MODE_PRIVATE)
        val current = prefs.getStringSet("alarms", emptySet())?.toMutableSet() ?: mutableSetOf()
        current.removeAll { it.startsWith("$id|") }
        current.add("$id|$hour|$minute")
        prefs.edit().putStringSet("alarms", current).apply()
    }

    private fun removeAlarmFromPrefs(id: Int) {
        val prefs = getSharedPreferences("myfarm_alarms", Context.MODE_PRIVATE)
        val current = prefs.getStringSet("alarms", emptySet())?.toMutableSet() ?: mutableSetOf()
        current.removeAll { it.startsWith("$id|") }
        prefs.edit().putStringSet("alarms", current).apply()
    }
}