package com.example.myfarm

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.media.AudioAttributes
import android.media.AudioManager
import android.media.MediaPlayer
import android.os.Build
import android.os.Bundle
import android.os.IBinder
import androidx.core.app.NotificationCompat

class AlarmService : Service() {

    private var mediaPlayer: MediaPlayer? = null

    companion object {

    const val CHANNEL_ID = "alarm_service_channel"
    const val NOTIFICATION_ID = 5001

    const val ACTION_STOP =
        "com.example.myfarm.STOP_ALARM"

    const val ACTION_SNOOZE =
        "com.example.myfarm.SNOOZE_ALARM"
}

    override fun onCreate() {
        super.onCreate()

        createNotificationChannel()

        val soundId = resources.getIdentifier(
            "alarm_sound",
            "raw",
            packageName
        )

        if (soundId != 0) {

            mediaPlayer = MediaPlayer()

            mediaPlayer?.apply {

            setAudioAttributes(
                AudioAttributes.Builder()
                    .setUsage(
                        AudioAttributes.USAGE_ALARM
                    )
                    .setContentType(
                        AudioAttributes.CONTENT_TYPE_SONIFICATION
                    )
                    .setFlags(
                        AudioAttributes.FLAG_AUDIBILITY_ENFORCED
                    )
                    .build()
            )

            val afd =
                resources.openRawResourceFd(soundId)

            setDataSource(
                afd.fileDescriptor,
                afd.startOffset,
                afd.length
            )

            afd.close()

            isLooping = true

            prepare()

            setVolume(
                1.0f,
                1.0f
            )
        }
        }
    }

    override fun onStartCommand(
    intent: Intent?,
    flags: Int,
    startId: Int
): Int {

    when (intent?.action) {

        ACTION_STOP -> {
            stopAlarm()
            return START_NOT_STICKY
        }

        ACTION_SNOOZE -> {
            snoozeAlarm(intent)
            return START_NOT_STICKY
        }
    }

    startAlarm()

    return START_STICKY
}

private fun snoozeAlarm(intent: Intent) {

    val alarmId = intent.getIntExtra("alarm_id", 9999)

    val alarmManager =
        getSystemService(ALARM_SERVICE) as android.app.AlarmManager

    val snoozeIntent = Intent(this, AlarmReceiver::class.java).apply {
        putExtra("alarm_id", alarmId)
    }

    val pendingIntent = android.app.PendingIntent.getBroadcast(
        this,
        alarmId,
        snoozeIntent,
        android.app.PendingIntent.FLAG_UPDATE_CURRENT or
            android.app.PendingIntent.FLAG_IMMUTABLE
    )

    val triggerTime = System.currentTimeMillis() + (10 * 60 * 1000) // 10 دقايق

    if (android.os.Build.VERSION.SDK_INT < android.os.Build.VERSION_CODES.S ||
        alarmManager.canScheduleExactAlarms()
    ) {
        alarmManager.setExactAndAllowWhileIdle(
            android.app.AlarmManager.RTC_WAKEUP,
            triggerTime,
            pendingIntent
        )
    }

    stopAlarm()
}

    private fun startAlarm() {

    // ==========================================
    // رفع صوت المنبه إلى أعلى مستوى
    // ==========================================

    val audioManager =
        getSystemService(Context.AUDIO_SERVICE) as AudioManager

    try {

        val maxAlarmVolume =
            audioManager.getStreamMaxVolume(
                AudioManager.STREAM_ALARM
            )

        audioManager.setStreamVolume(
            AudioManager.STREAM_ALARM,
            maxAlarmVolume,
            0
        )

    } catch (e: Exception) {
        e.printStackTrace()
    }

    // ==========================================
    // تشغيل صوت المنبه
    // ==========================================

    mediaPlayer?.let { player ->

        try {

            player.setVolume(
                1.0f,
                1.0f
            )

            player.isLooping = true

            if (!player.isPlaying) {
                player.start()
            }

        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    // ==========================================
    // شاشة المنبه
    // ==========================================

    val alarmIntent = Intent(
        this,
        AlarmActivity::class.java
    ).apply {

        addFlags(
            Intent.FLAG_ACTIVITY_NEW_TASK or
                    Intent.FLAG_ACTIVITY_CLEAR_TOP or
                    Intent.FLAG_ACTIVITY_SINGLE_TOP
        )
    }

    val alarmPendingIntent =
        PendingIntent.getActivity(
            this,
            2001,
            alarmIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or
                    PendingIntent.FLAG_IMMUTABLE
        )

    // ==========================================
    // Notification
    // ==========================================

    val notification =
        NotificationCompat.Builder(
            this,
            CHANNEL_ID
        )
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentTitle("MyFarm")
            .setContentText("حان وقت الاستيقاظ")
            .setPriority(
                NotificationCompat.PRIORITY_MAX
            )
            .setCategory(
                NotificationCompat.CATEGORY_ALARM
            )
            .setOngoing(true)
            .setAutoCancel(false)
            .setVisibility(
                NotificationCompat.VISIBILITY_PUBLIC
            )
            .setFullScreenIntent(
                alarmPendingIntent,
                true
            )
            .addAction(
                android.R.drawable.ic_media_pause,
                "إيقاف",
                createStopPendingIntent()
            )
            .build()

    startForeground(
        NOTIFICATION_ID,
        notification
    )

    // ==========================================
    // فتح شاشة المنبه
    // ==========================================

    if (android.provider.Settings.canDrawOverlays(this)) {

        try {
            startActivity(alarmIntent)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}

    private fun createStopPendingIntent(): PendingIntent {

        val stopIntent = Intent(
            this,
            AlarmService::class.java
        ).apply {
            action = ACTION_STOP
        }

        return PendingIntent.getService(
            this,
            3001,
            stopIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or
                PendingIntent.FLAG_IMMUTABLE
        )
    }

    private fun createNotificationChannel() {

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {

            val channel = NotificationChannel(
                CHANNEL_ID,
                "منبه MyFarm",
                NotificationManager.IMPORTANCE_HIGH
            )

            channel.description =
                "منبهات تطبيق MyFarm"

            // لا تستخدم Notification sound
            // لأن MediaPlayer هو المسؤول عن صوت المنبه
            channel.setSound(
                null,
                null
            )

            channel.enableVibration(true)

            channel.lockscreenVisibility =
                Notification.VISIBILITY_PUBLIC

            val manager =
                getSystemService(
                    NotificationManager::class.java
                )

            manager.createNotificationChannel(
                channel
            )
        }
    }

    private fun stopAlarm() {

        mediaPlayer?.let {

            try {

                if (it.isPlaying) {
                    it.stop()
                }

            } catch (e: Exception) {
                e.printStackTrace()
            }

            it.release()
        }

        mediaPlayer = null

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            stopForeground(STOP_FOREGROUND_REMOVE)
        } else {
            @Suppress("DEPRECATION")
            stopForeground(true)
        }

        stopSelf()
    }

    override fun onDestroy() {

        mediaPlayer?.let {

            try {

                if (it.isPlaying) {
                    it.stop()
                }

            } catch (e: Exception) {
                e.printStackTrace()
            }

            it.release()
        }

        mediaPlayer = null

        super.onDestroy()
    }

    override fun onBind(
        intent: Intent?
    ): IBinder? {
        return null
    }
}