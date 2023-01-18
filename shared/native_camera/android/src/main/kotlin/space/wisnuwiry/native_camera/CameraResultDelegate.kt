package space.wisnuwiry.native_camera

import android.app.Activity
import android.app.Activity.RESULT_OK
import android.content.Intent
import android.util.Log
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

class CameraResultDelegate(private var activity: Activity) : PluginRegistry.ActivityResultListener {

    var pendingResult: MethodChannel.Result? = null

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        Log.e(
            "RESULT",
            "Request Code: $requestCode, resultCode: $resultCode, data: ${data.toString()}"
        )
        if (requestCode == NativeCameraPlugin.REQUEST_CODE) {
            if (resultCode == RESULT_OK) {
                val path = data?.getStringExtra("photo")
                if (path != null) {
                    finishWithSuccess(path)
                }
                return true
            } else if (resultCode == NativeCameraPlugin.RESULT_ERROR) {
                val error = data?.getBundleExtra("error")
                if (error != null) {
                    finishWithFailure(
                        error.getString("code", ""),
                        error.getString("message", ""),
                        error.getString("stacktrace")
                    )
                }
                return true
            } else if (pendingResult != null) {
                pendingResult?.success(null)
                cleanMethodCallAndResult()
                return true
            }
        }

        return false
    }

    fun start(call: MethodCall, result: MethodChannel.Result) {
        pendingResult = result

        val params = call.arguments as Map<*, *>
        val intent = Intent(activity.applicationContext, CameraActivity::class.java)

        Log.e("LOG", "LENS TYPE: $params")
        intent.putExtra("lens_type", params["lens_type"] as Int)

        activity.startActivityForResult(intent, NativeCameraPlugin.REQUEST_CODE)
    }

    private fun finishWithSuccess(image: String) {
        if (pendingResult != null) {
            pendingResult!!.success(image)
            cleanMethodCallAndResult()
        }
    }

    private fun finishWithFailure(errorCode: String, message: String, stacktrace: String?) {
        if (pendingResult != null) {
            pendingResult!!.error(errorCode, message, stacktrace)
            cleanMethodCallAndResult()
        }
    }

    private fun cleanMethodCallAndResult() {
        pendingResult = null
    }

}