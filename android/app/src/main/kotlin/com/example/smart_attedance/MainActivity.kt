package com.example.smart_attedance

import android.app.ActivityManager
import android.app.admin.DevicePolicyManager
import android.content.ComponentName
import android.content.Context
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

/**
 * Main Activity with Kiosk Mode (Lock Task Mode) support.
 *
 * Communicates with the Flutter layer via MethodChannel to
 * start/stop Lock Task Mode and query its current state.
 */
class MainActivity : FlutterActivity() {

    companion object {
        private const val CHANNEL = "com.example.smart_attedance/kiosk"
        private const val TAG = "KioskMainActivity"
    }

    private lateinit var devicePolicyManager: DevicePolicyManager
    private lateinit var adminComponentName: ComponentName

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        devicePolicyManager = getSystemService(Context.DEVICE_POLICY_SERVICE) as DevicePolicyManager
        adminComponentName = ComponentName(this, KioskDeviceAdminReceiver::class.java)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "startLockTask" -> {
                        val success = startLockTaskModeIfOwner()
                        result.success(success)
                    }
                    "stopLockTask" -> {
                        val success = stopLockTaskMode()
                        result.success(success)
                    }
                    "isInLockTaskMode" -> {
                        val isLocked = isInLockTaskMode()
                        result.success(isLocked)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    /**
     * Attempts to start Lock Task Mode.
     *
     * Prerequisites:
     * - App must be registered as Device Owner
     * - Package must be whitelisted for lock task
     *
     * @return true if lock task mode was successfully started
     */
    private fun startLockTaskModeIfOwner(): Boolean {
        return try {
            if (!devicePolicyManager.isDeviceOwnerApp(packageName)) {
                Log.w(TAG, "App is NOT Device Owner — cannot start Lock Task Mode")
                Log.w(TAG, "Run: adb shell dpm set-device-owner $packageName/.KioskDeviceAdminReceiver")
                return false
            }

            // Whitelist this package for Lock Task Mode
            devicePolicyManager.setLockTaskPackages(adminComponentName, arrayOf(packageName))

            // Start Lock Task Mode
            startLockTask()
            Log.d(TAG, "Lock Task Mode STARTED")
            true
        } catch (e: Exception) {
            Log.e(TAG, "Error starting Lock Task Mode", e)
            false
        }
    }

    /**
     * Stops Lock Task Mode, allowing the user to navigate away.
     *
     * @return true if lock task mode was successfully stopped
     */
    private fun stopLockTaskMode(): Boolean {
        return try {
            stopLockTask()
            Log.d(TAG, "Lock Task Mode STOPPED")
            true
        } catch (e: Exception) {
            Log.e(TAG, "Error stopping Lock Task Mode", e)
            false
        }
    }

    /**
     * Checks if the app is currently in Lock Task Mode.
     *
     * @return true if lock task mode is active
     */
    private fun isInLockTaskMode(): Boolean {
        val activityManager = getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        val lockTaskMode = activityManager.lockTaskModeState
        val isLocked = lockTaskMode != ActivityManager.LOCK_TASK_MODE_NONE
        Log.d(TAG, "Lock Task Mode state: $lockTaskMode (isLocked=$isLocked)")
        return isLocked
    }
}
