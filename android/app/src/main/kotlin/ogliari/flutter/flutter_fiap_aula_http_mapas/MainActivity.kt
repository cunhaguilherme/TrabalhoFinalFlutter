package ogliari.flutter.flutter_fiap_aula_http_mapas

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.widget.Toast  
import android.content.Intent
import android.os.Bundle
import android.view.View
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {

    private val CHANNEL = "com.test/test"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
        call, result ->
            if (call.method == "showAlert") {
                val msg = call.argument<String>("msg") // msg
                Toast.makeText(this,msg,Toast.LENGTH_SHORT).show();
            } else {
                result.notImplemented()
            }
        }
    }

}
