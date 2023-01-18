package rekab.app.background_locator.http

import android.util.Log
import androidx.annotation.MainThread
import okhttp3.MediaType
import okhttp3.MediaType.Companion.toMediaTypeOrNull
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody
import okhttp3.RequestBody.Companion.toRequestBody
import java.util.concurrent.ExecutorService

class HttpClientService constructor(
    private val client: OkHttpClient,
    private val executor: ExecutorService
    ){

    @MainThread
    fun run(params: RequestParams) {
        executor.execute {
            try {
                val contentTypeJSON = "application/json; charset=utf-8".toMediaTypeOrNull()

                val request = Request.Builder()
                    .url(params.url)
                    .method("POST", params.body.toRequestBody(contentTypeJSON))
                    .post(params.body.toRequestBody())
                    .header("Content-Type", "application/json")

                if (params.headers != null) {
                    for (item in params.headers) {
                        request.header(
                            item.key,
                            item.value.toString(),
                        )
                    }
                }

                val requestBuild = request.build()

                Log.d("LOCATION", "Starting Request to API \nBody: ${params.body}\n Headers: ${requestBuild.headers}")

                client.newCall(requestBuild).execute().use { response ->
                    if (!response.isSuccessful) Log.d("ERROR_REQUEST", "response: ${response.body?.string()}")

                    Log.d("Location", "RESPONSE: ${response.body?.string()}")
                }
            } catch (e: Exception) {
                Log.d("Location", "ERROR: ${e.localizedMessage} ${e.printStackTrace()}")
            } finally {
                Log.d("Location", "Finally Upload to Server")
            }
        }
    }

    companion object {
        @Volatile private var INSTANCE: HttpClientService? = null

        fun getInstance(client: OkHttpClient,
                        executor: ExecutorService): HttpClientService {
            return INSTANCE ?: synchronized(this) {
                INSTANCE ?: HttpClientService(
                    client,

                    executor)
                    .also { INSTANCE = it }
            }
        }
    }
}

class RequestParams constructor(url: String, body: String, headers: Map<String, Any>?) {
    val url: String = url
    val body: String = body
    val headers: Map<String, Any>? = headers
}
