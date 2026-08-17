package com.example.myfarm

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import androidx.core.content.ContextCompat

class AlarmReceiver : BroadcastReceiver() {

    override fun onReceive(
        context: Context,
        intent: Intent
    ) {

        val alarmId = intent.getIntExtra(
            "alarm_id",
            1001
        )

        val serviceIntent = Intent(
            context,
            AlarmService::class.java
        ).apply {
            putExtra(
                "alarm_id",
                alarmId
            )
        }

        ContextCompat.startForegroundService(
            context,
            serviceIntent
        )
    }
}