package com.example.myfarm

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.os.IBinder
import androidx.core.app.NotificationCompat
import io.flutter.FlutterInjector
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

class AmbientForegroundService : Service() {

    companion object {
        const val CHANNEL_ID = "ambient_service_channel"
        const val NOTIFICATION_ID = 6001

        const val AMBIENT_ALERT_CHANNEL_ID = "ambient_alert_channel"
        const val AMBIENT_ALERT_NOTIFICATION_ID = 6002

        const val AMBIENT_ENGINE_ID = "ambient_engine"

        @Volatile
        var isAmbientVisible: Boolean = false
    }

    private var screenReceiver: BroadcastReceiver? = null

    override fun onCreate() {
        super.onCreate()
        android.util.Log.d("AmbientService", "onCreate called")
        createNotificationChannels()
        startForeground(NOTIFICATION_ID, buildNotification())
        android.util.Log.d("AmbientService", "startForeground succeeded")
        ensureAmbientEngineExists()
        registerScreenReceiver()
        android.util.Log.d("AmbientService", "receiver registered")
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        return START_STICKY
    }

    private fun ensureAmbientEngineExists() {
        val cache = FlutterEngineCache.getInstance()

        if (cache.get(AMBIENT_ENGINE_ID) == null) {
            val engine = FlutterEngine(applicationContext)

            engine.dartExecutor.executeDartEntrypoint(
                DartExecutor.DartEntrypoint(
                    FlutterInjector.instance().flutterLoader().findAppBundlePath(),
                    "ambientMain"
                )
            )

            // سجّل القناة فورًا هنا — من غير ما تستنى أي Activity تتصل بالـ engine
            AmbientChannelHandler.register(applicationContext, engine)

            cache.put(AMBIENT_ENGINE_ID, engine)

            android.util.Log.d("AmbientService", "engine created and channel registered")
        }
    }

    private fun registerScreenReceiver() {
        if (screenReceiver != null) return

        screenReceiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent?) {
                android.util.Log.d("AmbientService", "onReceive: action=${intent?.action}")

                when (intent?.action) {
                    Intent.ACTION_SCREEN_OFF -> {
                        android.util.Log.d(
                            "AmbientService",
                            "SCREEN_OFF"
                        )

                        closeAmbientScreenIfVisible()
                    }
                    Intent.ACTION_SCREEN_ON -> {
                        android.util.Log.d("AmbientService", "SCREEN_ON received")

                        if (!isAmbientEnabled()) {
                            android.util.Log.d("AmbientService", "Ambient is disabled")
                            return
                        }

                        if (isAmbientVisible) {
                            android.util.Log.d("AmbientService", "Ambient already visible")
                            return
                        }

                        // ⚠️ استخدم الإشعار كامل الشاشة بدل startActivity المباشر
                        // لأن Android بيمنع فتح Activity من Service في الخلفية مباشرة (BAL restriction)
                        showAmbientFullScreenNotification(context)
                        isAmbientVisible = true
                    }
                    Intent.ACTION_USER_PRESENT -> {
                        // المستخدم فك القفل فعليًا (بصمة/وش/PIN).
                        // اقفل شاشة الـ Ambient بنظافة عشان متتصارعش مع الشاشة الأساسية.
                        android.util.Log.d("AmbientService", "ACTION_USER_PRESENT — closing ambient screen")
                        closeAmbientScreenIfVisible()
                    }
                }
            }
        }

        val filter = IntentFilter().apply {
            addAction(Intent.ACTION_SCREEN_ON)
            addAction(Intent.ACTION_SCREEN_OFF)
            addAction(Intent.ACTION_USER_PRESENT)
        }

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            registerReceiver(screenReceiver, filter, Context.RECEIVER_NOT_EXPORTED)
        } else {
            registerReceiver(screenReceiver, filter)
        }
    }

    private fun closeAmbientScreenIfVisible() {
        if (!isAmbientVisible) return

        LockScreenActivity.instance?.finish()
        isAmbientVisible = false

        // مهم: امسح الإشعار عشان المرة الجاية يتبعث "جديد" فعليًا ويعيد تفعيل الـ full-screen launch
        val manager = getSystemService(NotificationManager::class.java)
        manager.cancel(AMBIENT_ALERT_NOTIFICATION_ID)
    }

    // ============================================================
    // Full-Screen Intent — الطريقة الرسمية لفتح Activity فوق شاشة القفل
    // ============================================================

    private fun showAmbientFullScreenNotification(context: Context) {

        val manager = getSystemService(NotificationManager::class.java)

        // امسح أي إشعار قديم بنفس الـ ID قبل ما تبعت واحد جديد
        manager.cancel(AMBIENT_ALERT_NOTIFICATION_ID)

        val ambientIntent = Intent(context, LockScreenActivity::class.java).apply {
            addFlags(
                Intent.FLAG_ACTIVITY_NEW_TASK or
                    Intent.FLAG_ACTIVITY_CLEAR_TOP or
                    Intent.FLAG_ACTIVITY_SINGLE_TOP
            )
        }

        val fullScreenPendingIntent = PendingIntent.getActivity(
            context,
            0,
            ambientIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        val notification = NotificationCompat.Builder(context, AMBIENT_ALERT_CHANNEL_ID)
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentTitle("MyFarm")
            .setContentText("Ambient Screen")
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setCategory(NotificationCompat.CATEGORY_ALARM)
            .setFullScreenIntent(fullScreenPendingIntent, true)
            .setAutoCancel(true)
            .setOngoing(false)
            .build()

        android.util.Log.d(
            "AmbientService",
            "canUseFullScreenIntent = ${
                if (Build.VERSION.SDK_INT >= 34) manager.canUseFullScreenIntent() else true
            }"
        )

        manager.notify(AMBIENT_ALERT_NOTIFICATION_ID, notification)

        android.util.Log.d("AmbientService", "full-screen notification posted")
    }

    private fun isAmbientEnabled(): Boolean {
        val prefs = getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
        return prefs.getBoolean("flutter.ambient_enabled", false)
    }

    private fun buildNotification(): Notification {
        return NotificationCompat.Builder(this, CHANNEL_ID)
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentTitle("MyFarm")
            .setContentText("Ambient Screen شغالة")
            .setPriority(NotificationCompat.PRIORITY_MIN)
            .setOngoing(true)
            .setSilent(true)
            .build()
    }

    private fun createNotificationChannels() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val manager = getSystemService(NotificationManager::class.java)

            val serviceChannel = NotificationChannel(
                CHANNEL_ID, "Ambient Screen", NotificationManager.IMPORTANCE_MIN
            )
            serviceChannel.description = "خدمة تشغيل شاشة القفل الافتراضية"
            manager.createNotificationChannel(serviceChannel)

            val alertChannel = NotificationChannel(
                AMBIENT_ALERT_CHANNEL_ID,
                "Ambient Alert",
                NotificationManager.IMPORTANCE_HIGH
            )
            alertChannel.description = "تنبيه فتح شاشة الـ Ambient"
            alertChannel.setSound(null, null)
            manager.createNotificationChannel(alertChannel)
        }
    }

    override fun onDestroy() {
        android.util.Log.e("AmbientService", "⚠️ Service onDestroy — killed by system!")
        screenReceiver?.let {
            try { unregisterReceiver(it) } catch (e: Exception) { e.printStackTrace() }
        }
        screenReceiver = null
        super.onDestroy()
    }

    override fun onBind(intent: Intent?): IBinder? = null
}