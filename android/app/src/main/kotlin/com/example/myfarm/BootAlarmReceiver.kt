package com.example.myfarm

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import java.util.Calendar

class BootAlarmReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context, intent: Intent) {

        if (intent.action != Intent.ACTION_BOOT_COMPLETED) return

        val prefs = context.getSharedPreferences(
            "myfarm_alarms",
            Context.MODE_PRIVATE
        )

        val savedAlarms = prefs.getStringSet("alarms", emptySet()) ?: emptySet()

        val alarmManager =
            context.getSystemService(Context.ALARM_SERVICE) as AlarmManager

        for (entry in savedAlarms) {
            // الصيغة المخزنة: "id|hour|minute"
            val parts = entry.split("|")
            if (parts.size != 3) continue

            val id = parts[0].toIntOrNull() ?: continue
            val hour = parts[1].toIntOrNull() ?: continue
            val minute = parts[2].toIntOrNull() ?: continue

            val now = Calendar.getInstance()
            val next = Calendar.getInstance().apply {
                set(Calendar.HOUR_OF_DAY, hour)
                set(Calendar.MINUTE, minute)
                set(Calendar.SECOND, 0)
                if (before(now)) add(Calendar.DAY_OF_YEAR, 1)
            }

            val alarmIntent = Intent(context, AlarmReceiver::class.java).apply {
                putExtra("alarm_id", id)
            }

            val pendingIntent = PendingIntent.getBroadcast(
                context,
                id,
                alarmIntent,
                PendingIntent.FLAG_UPDATE_CURRENT or
                    PendingIntent.FLAG_IMMUTABLE
            )

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S &&
                !alarmManager.canScheduleExactAlarms()
            ) continue

            alarmManager.setExactAndAllowWhileIdle(
                AlarmManager.RTC_WAKEUP,
                next.timeInMillis,
                pendingIntent
            )
        }
    }
}