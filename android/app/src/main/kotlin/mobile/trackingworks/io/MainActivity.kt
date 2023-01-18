package mobile.trackingworks.io

import android.os.Build
import android.os.Environment
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    companion object{
        private const val CHANNEL = "mobile.trackingworks.io"
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "download_folder_path") {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                    result.success(getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS)?.path)
                } else {
                    result.success(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS).path)
                }
            }
        }
    }

}
