package com.example.myfarm

import android.app.Activity
import android.content.Intent
import android.content.res.ColorStateList
import android.graphics.Color
import android.graphics.Typeface
import android.graphics.drawable.GradientDrawable
import android.graphics.drawable.RippleDrawable
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.view.Gravity
import android.view.View
import android.view.WindowInsets
import android.view.WindowManager
import android.widget.FrameLayout
import android.widget.LinearLayout
import android.widget.TextView
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Locale

class AlarmActivity : Activity() {

    private val handler = Handler(Looper.getMainLooper())

    private lateinit var clockTextView: TextView
    private lateinit var dateTextView: TextView

    private val arabicDays = arrayOf(
        "",
        "الأحد",
        "الاثنين",
        "الثلاثاء",
        "الأربعاء",
        "الخميس",
        "الجمعة",
        "السبت"
    )

    private val arabicMonths = arrayOf(
        "يناير",
        "فبراير",
        "مارس",
        "أبريل",
        "مايو",
        "يونيو",
        "يوليو",
        "أغسطس",
        "سبتمبر",
        "أكتوبر",
        "نوفمبر",
        "ديسمبر"
    )

    private val clockRunnable = object : Runnable {
        override fun run() {
            updateClock()
            handler.postDelayed(this, 1000)
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setupAlarmWindow()
        createAlarmScreen()

        updateClock()
        handler.post(clockRunnable)
    }

    private fun dp(value: Int): Int {
        return (value * resources.displayMetrics.density).toInt()
    }

    private fun setupAlarmWindow() {

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O_MR1) {
            setShowWhenLocked(true)
            setTurnScreenOn(true)
        }

        window.addFlags(
            WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON or
                    WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON or
                    WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED
        )

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            window.addFlags(
                WindowManager.LayoutParams.FLAG_ALLOW_LOCK_WHILE_SCREEN_ON
            )
        }

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O_MR1) {
            window.addFlags(
                WindowManager.LayoutParams.FLAG_DISMISS_KEYGUARD
            )
        }

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {

    window.setDecorFitsSystemWindows(false)

    window.decorView.post {

        val controller = window.insetsController

        if (controller != null) {

            controller.hide(
                WindowInsets.Type.statusBars() or
                        WindowInsets.Type.navigationBars()
            )

            controller.systemBarsBehavior =
                android.view.WindowInsetsController
                    .BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        }
    }

} else {

    @Suppress("DEPRECATION")
    window.decorView.systemUiVisibility =
        View.SYSTEM_UI_FLAG_FULLSCREEN or
                View.SYSTEM_UI_FLAG_HIDE_NAVIGATION or
                View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY or
                View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN or
                View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION or
                View.SYSTEM_UI_FLAG_LAYOUT_STABLE
}
    }

    private fun updateClock() {

        val now = Calendar.getInstance()

        val timeFormat =
            SimpleDateFormat("hh:mm", Locale.US)

        val currentTime =
            timeFormat.format(now.time)

        val amPm =
            if (now.get(Calendar.AM_PM) == Calendar.AM) {
                "ص"
            } else {
                "م"
            }

        clockTextView.text =
            "$currentTime $amPm"

        val day =
            arabicDays[now.get(Calendar.DAY_OF_WEEK)]

        val date =
            now.get(Calendar.DAY_OF_MONTH)

        val month =
            arabicMonths[now.get(Calendar.MONTH)]

        dateTextView.text =
            "$day، $date $month"
    }

    private fun createAlarmScreen() {

        val rootBackground = GradientDrawable(
            GradientDrawable.Orientation.TOP_BOTTOM,
            intArrayOf(
                Color.rgb(20, 28, 48),
                Color.rgb(8, 11, 20)
            )
        )

        val root = LinearLayout(this).apply {

            orientation = LinearLayout.VERTICAL

            gravity = Gravity.CENTER_HORIZONTAL

            background = rootBackground

            setPadding(
                dp(28),
                dp(45),
                dp(28),
                dp(30)
            )
        }

        // MyFarm

        val appName = TextView(this).apply {

            text = "MyFarm"

            textSize = 17f

            gravity = Gravity.CENTER

            setTextColor(
                Color.rgb(145, 155, 180)
            )

            typeface = Typeface.create(
                Typeface.DEFAULT,
                Typeface.NORMAL
            )

            letterSpacing = 0.12f
        }

        root.addView(
            appName,
            LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.WRAP_CONTENT
            )
        )

        // التاريخ

        dateTextView = TextView(this).apply {

            textSize = 17f

            gravity = Gravity.CENTER

            setTextColor(
                Color.rgb(170, 178, 200)
            )

            setPadding(
                0,
                dp(14),
                0,
                0
            )
        }

        root.addView(
            dateTextView,
            LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.WRAP_CONTENT
            )
        )

        // الساعة

        clockTextView = TextView(this).apply {

            textSize = 78f

            gravity = Gravity.CENTER

            setTextColor(Color.WHITE)

            typeface = Typeface.create(
                Typeface.DEFAULT,
                Typeface.NORMAL
            )

            includeFontPadding = false

            setPadding(
                0,
                dp(25),
                0,
                dp(8)
            )
        }

        root.addView(
            clockTextView,
            LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.WRAP_CONTENT
            )
        )

        // Badge

        val badgeBackground = GradientDrawable().apply {

            shape = GradientDrawable.RECTANGLE

            cornerRadius = dp(30).toFloat()

            setColor(
                Color.rgb(48, 39, 28)
            )

            setStroke(
                dp(1),
                Color.rgb(100, 78, 48)
            )
        }

        val alarmBadge = TextView(this).apply {

            text = "⏰  منبه"

            textSize = 15f

            gravity = Gravity.CENTER

            setTextColor(
                Color.rgb(255, 190, 100)
            )

            setPadding(
                dp(22),
                dp(10),
                dp(22),
                dp(10)
            )

            background = badgeBackground
        }

        root.addView(
            alarmBadge,
            LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.WRAP_CONTENT,
                LinearLayout.LayoutParams.WRAP_CONTENT
            ).apply {
                topMargin = dp(5)
            }
        )

        // العنوان

        val title = TextView(this).apply {

            text = "حان وقت الاستيقاظ"

            textSize = 22f

            gravity = Gravity.CENTER

            setTextColor(Color.WHITE)

            typeface = Typeface.create(
                Typeface.DEFAULT,
                Typeface.BOLD
            )

            setPadding(
                0,
                dp(28),
                0,
                0
            )
        }

        root.addView(
            title,
            LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.WRAP_CONTENT
            )
        )

        // مساحة مرنة

        val spacer = View(this)

        root.addView(
            spacer,
            LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                0,
                1f
            )
        )

        // الأزرار

        val buttonsRow = LinearLayout(this).apply {

            orientation =
                LinearLayout.HORIZONTAL

            gravity =
                Gravity.CENTER

            layoutDirection =
                View.LAYOUT_DIRECTION_LTR
        }

        val snoozeButton =
            createSnoozeButton()

        buttonsRow.addView(
            snoozeButton,
            LinearLayout.LayoutParams(
                dp(145),
                dp(145)
            ).apply {
                marginEnd = dp(25)
            }
        )

        val stopButton =
            createStopButton()

        buttonsRow.addView(
            stopButton,
            LinearLayout.LayoutParams(
                dp(175),
                dp(175)
            )
        )

        root.addView(
            buttonsRow,
            LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.WRAP_CONTENT
            ).apply {
                bottomMargin = dp(15)
            }
        )

        // النص السفلي

        val hintTextView = TextView(this).apply {

            text = "اضغط لإيقاف المنبه أو غفوة"

            textSize = 12f

            gravity = Gravity.CENTER

            setTextColor(
                Color.rgb(105, 115, 140)
            )

            setPadding(
                0,
                dp(10),
                0,
                0
            )
        }

        root.addView(
            hintTextView,
            LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.WRAP_CONTENT
            )
        )

        setContentView(root)
    }

    private fun createSnoozeButton(): View {

        val snoozeBackground = GradientDrawable().apply {

            shape = GradientDrawable.OVAL

            setColor(
                Color.rgb(34, 45, 70)
            )

            setStroke(
                dp(2),
                Color.rgb(85, 100, 130)
            )
        }

        val ripple = RippleDrawable(
            ColorStateList.valueOf(
                Color.argb(
                    70,
                    255,
                    255,
                    255
                )
            ),
            snoozeBackground,
            snoozeBackground
        )

        val container = FrameLayout(this).apply {

            background = ripple

            isClickable = true

            isFocusable = true

            elevation = dp(5).toFloat()

            setOnClickListener {

                val intent =
                    Intent(
                        this@AlarmActivity,
                        AlarmService::class.java
                    ).apply {
                        action =
                            AlarmService.ACTION_SNOOZE
                    }

                startService(intent)

                finish()
            }
        }

        val content = LinearLayout(this).apply {

            orientation =
                LinearLayout.VERTICAL

            gravity =
                Gravity.CENTER
        }

        val iconTextView = TextView(this).apply {

            text = "😴"

            textSize = 38f

            gravity = Gravity.CENTER
        }

        val labelTextView = TextView(this).apply {

            text = "غفوة"

            textSize = 15f

            gravity = Gravity.CENTER

            setTextColor(
                Color.rgb(220, 225, 235)
            )

            typeface =
                Typeface.DEFAULT_BOLD

            setPadding(
                0,
                dp(7),
                0,
                0
            )
        }

        val durationTextView = TextView(this).apply {

            text = "10 دقائق"

            textSize = 11f

            gravity = Gravity.CENTER

            setTextColor(
                Color.rgb(135, 145, 165)
            )

            setPadding(
                0,
                dp(2),
                0,
                0
            )
        }

        content.addView(iconTextView)
        content.addView(labelTextView)
        content.addView(durationTextView)

        container.addView(
            content,
            FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.MATCH_PARENT,
                Gravity.CENTER
            )
        )

        return container
    }

    private fun createStopButton(): View {

        val stopBackground = GradientDrawable(
            GradientDrawable.Orientation.TOP_BOTTOM,
            intArrayOf(
                Color.rgb(255, 92, 95),
                Color.rgb(190, 35, 45)
            )
        ).apply {

            shape = GradientDrawable.OVAL

            setStroke(
                dp(3),
                Color.rgb(255, 150, 150)
            )
        }

        val ripple = RippleDrawable(
            ColorStateList.valueOf(
                Color.argb(
                    90,
                    255,
                    255,
                    255
                )
            ),
            stopBackground,
            stopBackground
        )

        val container = FrameLayout(this).apply {

            background = ripple

            isClickable = true

            isFocusable = true

            elevation = dp(12).toFloat()

            setOnClickListener {

                val intent =
                    Intent(
                        this@AlarmActivity,
                        AlarmService::class.java
                    ).apply {
                        action =
                            AlarmService.ACTION_STOP
                    }

                startService(intent)

                finish()
            }
        }

        val content = LinearLayout(this).apply {

            orientation =
                LinearLayout.VERTICAL

            gravity =
                Gravity.CENTER
        }

        val iconTextView = TextView(this).apply {

            text = "🌞"

            textSize = 42f

            gravity = Gravity.CENTER

            setTextColor(Color.WHITE)

            typeface =
                Typeface.DEFAULT_BOLD
        }

        val labelTextView = TextView(this).apply {

            text = "إيقاف"

            textSize = 16f

            gravity = Gravity.CENTER

            setTextColor(Color.WHITE)

            typeface =
                Typeface.DEFAULT_BOLD

            setPadding(
                0,
                dp(5),
                0,
                0
            )
        }

        content.addView(iconTextView)
        content.addView(labelTextView)

        container.addView(
            content,
            FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.MATCH_PARENT,
                Gravity.CENTER
            )
        )

        return container
    }

    @Deprecated("Deprecated in Java")
    override fun onBackPressed() {
        // منع الخروج من شاشة المنبه
    }

    override fun onDestroy() {

        handler.removeCallbacks(
            clockRunnable
        )

        super.onDestroy()
    }
}