package com.example.myfarm

import android.os.Build
import android.os.Bundle
import android.view.View
import android.view.WindowInsets
import android.view.WindowInsetsController
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import android.app.NotificationManager

class LockScreenActivity : FlutterActivity() {

    companion object {
        var instance: LockScreenActivity? = null
    }

    override fun provideFlutterEngine(
        context: android.content.Context
    ): FlutterEngine? {
        return FlutterEngineCache
            .getInstance()
            .get(AmbientForegroundService.AMBIENT_ENGINE_ID)
    }

    override fun shouldDestroyEngineWithHost(): Boolean {
        return false
    }

    override fun getInitialRoute(): String {
        return "/ambient"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        instance = this

        setupLockScreen()
    }

    override fun configureFlutterEngine(
        flutterEngine: FlutterEngine
    ) {
        super.configureFlutterEngine(flutterEngine)

        AmbientChannelHandler.register(
            this,
            flutterEngine
        )
    }

    private fun setupLockScreen() {

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O_MR1) {
            setShowWhenLocked(true)
            setTurnScreenOn(true)
        } else {
            @Suppress("DEPRECATION")
            window.addFlags(
                WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED or
                    WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON or
                    WindowManager.LayoutParams.FLAG_DISMISS_KEYGUARD
            )
        }

        window.addFlags(
            WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON
        )

        hideSystemUi()
    }

    private fun hideSystemUi() {

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {

            window.insetsController?.let { controller ->

                controller.hide(
                    WindowInsets.Type.statusBars() or
                        WindowInsets.Type.navigationBars()
                )

                controller.systemBarsBehavior =
                    WindowInsetsController.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
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

    override fun onResume() {
        super.onResume()

        instance = this

        setupLockScreen()
    }

    override fun onDestroy() {
        AmbientForegroundService.isAmbientVisible = false

        // امسح الإشعار من هنا كمان (احتياطي، حتى لو الإغلاق حصل بطريقة تانية غير SCREEN_OFF)
        val manager = getSystemService(NotificationManager::class.java)
        manager.cancel(AmbientForegroundService.AMBIENT_ALERT_NOTIFICATION_ID)

        if (instance === this) {
            instance = null
        }
        super.onDestroy()
    }
}