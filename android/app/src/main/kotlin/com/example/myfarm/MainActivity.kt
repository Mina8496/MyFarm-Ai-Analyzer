package com.example.myfarm

import android.Manifest
import android.app.AlarmManager
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.PowerManager
import android.provider.Settings
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "myfarm_alarm"
    private val AMBIENT_CHANNEL = "myfarm_ambient"
    private val NOTIFICATION_PERMISSION_REQUEST_CODE = 1001

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        setupAlarmChannel(flutterEngine)
        setupAmbientChannel(flutterEngine)
    }

    override fun onResume() {
        super.onResume()
        requestNotificationPermissionIfNeeded()
        checkAndRequestFullScreenIntentIfNeeded()
    }

    // في MainActivity.kt

    override fun onCreate(savedInstanceState: Bundle?) {
            super.onCreate(savedInstanceState)
            ensureAmbientServiceRunningIfEnabled()
        }

        private fun ensureAmbientServiceRunningIfEnabled() {
            val prefs = getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
            val enabled = prefs.getBoolean("flutter.ambient_enabled", false)

            if (!enabled) return

            if (!isAmbientServiceRunning()) {
                try {
                    val serviceIntent = Intent(this, AmbientForegroundService::class.java)
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                        startForegroundService(serviceIntent)
                    } else {
                        startService(serviceIntent)
                    }
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }
        }

        private fun isAmbientServiceRunning(): Boolean {
            val manager = getSystemService(Context.ACTIVITY_SERVICE) as android.app.ActivityManager

            @Suppress("DEPRECATION")
            val runningServices = manager.getRunningServices(Int.MAX_VALUE)

            return runningServices.any {
                it.service.className == AmbientForegroundService::class.java.name
            }
        }

    // ============================================================
    // Notification Permission (Android 13+)
    // ============================================================

    private fun requestNotificationPermissionIfNeeded() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            val granted = ContextCompat.checkSelfPermission(
                this,
                Manifest.permission.POST_NOTIFICATIONS
            ) == PackageManager.PERMISSION_GRANTED

            if (!granted) {
                android.util.Log.w("MainActivity", "Requesting POST_NOTIFICATIONS permission")
                ActivityCompat.requestPermissions(
                    this,
                    arrayOf(Manifest.permission.POST_NOTIFICATIONS),
                    NOTIFICATION_PERMISSION_REQUEST_CODE
                )
            }
        }
    }

    // ============================================================
    // Full Screen Intent Permission Check
    // ============================================================

    private fun checkAndRequestFullScreenIntentIfNeeded() {
        val prefs = getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
        val ambientEnabled = prefs.getBoolean("flutter.ambient_enabled", false)

        if (!ambientEnabled) return

        if (Build.VERSION.SDK_INT >= 34) {
            val manager = getSystemService(NotificationManager::class.java)
            if (!manager.canUseFullScreenIntent()) {
                android.util.Log.w("MainActivity", "Full screen intent permission was revoked — re-requesting")
                val intent = Intent(Settings.ACTION_MANAGE_APP_USE_FULL_SCREEN_INTENT).apply {
                    data = Uri.parse("package:$packageName")
                }
                startActivity(intent)
            }
        }
    }

    // ============================================================
    // Ambient Channel
    // ============================================================

    private fun setupAmbientChannel(flutterEngine: FlutterEngine) {
        AmbientChannelHandler.register(this, flutterEngine)
    }

    private fun openAmbientActivity() {
        val intent = Intent(this, LockScreenActivity::class.java).apply {
            addFlags(
                Intent.FLAG_ACTIVITY_NEW_TASK or
                    Intent.FLAG_ACTIVITY_CLEAR_TOP or
                    Intent.FLAG_ACTIVITY_SINGLE_TOP
            )
        }
        startActivity(intent)
    }

    // ============================================================
    // Alarm Channel
    // ============================================================

    private fun setupAlarmChannel(flutterEngine: FlutterEngine) {

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
                    val granted =
                        Build.VERSION.SDK_INT < Build.VERSION_CODES.M ||
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
                                "requestExactAlarmPermission" -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                        try {
                            val intent = Intent(Settings.ACTION_REQUEST_SCHEDULE_EXACT_ALARM).apply {
                                data = Uri.parse("package:$packageName")
                            }
                            startActivity(intent)
                        } catch (e: Exception) {
                            e.printStackTrace()
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

    // ============================================================
    // Alarm Functions
    // ============================================================

    private fun scheduleAlarm(id: Int, timestamp: Long) {
        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            if (!alarmManager.canScheduleExactAlarms()) {
                throw IllegalStateException("Exact alarm permission is not granted")
            }
        }

        val intent = Intent(this, AlarmReceiver::class.java).apply {
            putExtra("alarm_id", id)
        }

        val pendingIntent = PendingIntent.getBroadcast(
            this,
            id,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        alarmManager.setExactAndAllowWhileIdle(
            AlarmManager.RTC_WAKEUP,
            timestamp,
            pendingIntent
        )
    }

    private fun cancelAlarm(id: Int) {
        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager

        val intent = Intent(this, AlarmReceiver::class.java)

        val pendingIntent = PendingIntent.getBroadcast(
            this,
            id,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        alarmManager.cancel(pendingIntent)
        pendingIntent.cancel()
    }

    private fun canScheduleExactAlarms(): Boolean {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) {
            return true
        }

        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
        return alarmManager.canScheduleExactAlarms()
    }

    private fun saveAlarmToPrefs(id: Int, hour: Int, minute: Int) {
        val prefs = getSharedPreferences("myfarm_alarms", Context.MODE_PRIVATE)

        val current = prefs.getStringSet("alarms", emptySet())
            ?.toMutableSet() ?: mutableSetOf()

        current.removeAll { it.startsWith("$id|") }
        current.add("$id|$hour|$minute")

        prefs.edit().putStringSet("alarms", current).apply()
    }

    private fun removeAlarmFromPrefs(id: Int) {
        val prefs = getSharedPreferences("myfarm_alarms", Context.MODE_PRIVATE)

        val current = prefs.getStringSet("alarms", emptySet())
            ?.toMutableSet() ?: mutableSetOf()

        current.removeAll { it.startsWith("$id|") }

        prefs.edit().putStringSet("alarms", current).apply()
    }
}