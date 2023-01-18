package rekab.app.background_locator

import android.content.Context
import android.util.Log
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import rekab.app.background_locator.provider.LocationClient

class PreferencesManager {
    companion object {
        private const val PREF_NAME = "background_locator"

        @JvmStatic
        fun saveCallbackDispatcher(context: Context, map: Map<Any, Any?>) {
            val sharedPreferences =
                context.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE)

            sharedPreferences.edit()
                .putLong(
                    Keys.ARG_CALLBACK_DISPATCHER,
                    map[Keys.ARG_CALLBACK_DISPATCHER] as Long
                )
                .apply()
        }

        @JvmStatic
        fun saveSettings(context: Context, map: Map<Any, Any?>) {
            Log.d("LOCATION", "Save Setting: $map")
            val sharedPreferences =
                context.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE)

            if (map[Keys.ARG_NOTIFICATION_CALLBACK] is Long) {
                sharedPreferences.edit()
                    .putLong(
                        Keys.ARG_NOTIFICATION_CALLBACK,
                        map[Keys.ARG_NOTIFICATION_CALLBACK] as Long
                    )
                    .apply()
            }

            if (map[Keys.SETTINGS_NETWORK_URL] is String) {
                sharedPreferences.edit()
                    .putString(
                        Keys.SETTINGS_NETWORK_URL,
                        map[Keys.SETTINGS_NETWORK_URL] as String
                    )
                    .apply()
            }

            if (map[Keys.SETTINGS_NETWORK_HEADERS] is String) {
                sharedPreferences.edit()
                    .putString(
                        Keys.SETTINGS_NETWORK_HEADERS,
                        map[Keys.SETTINGS_NETWORK_HEADERS].toString()
                    )
                    .apply()
            }

            if (map[Keys.SETTINGS_NETWORK_METHOD] is String) {
                sharedPreferences.edit()
                    .putString(
                        Keys.SETTINGS_NETWORK_METHOD,
                        map[Keys.SETTINGS_NETWORK_METHOD] as String
                    )
                    .apply()
            }

            if (map[Keys.SETTINGS_ANDROID_NOTIFICATION_CHANNEL_NAME] is String) {
                sharedPreferences.edit()
                    .putString(
                        Keys.SETTINGS_ANDROID_NOTIFICATION_CHANNEL_NAME,
                        map[Keys.SETTINGS_ANDROID_NOTIFICATION_CHANNEL_NAME] as String
                    )
                    .apply()
            }

            if (map[Keys.SETTINGS_ANDROID_NOTIFICATION_TITLE] is String) {
                sharedPreferences.edit()
                    .putString(
                        Keys.SETTINGS_ANDROID_NOTIFICATION_TITLE,
                        map[Keys.SETTINGS_ANDROID_NOTIFICATION_TITLE] as String
                    )
                    .apply()
            }

            if (map[Keys.SETTINGS_ANDROID_NOTIFICATION_MSG] is String) {
                sharedPreferences.edit()
                    .putString(
                        Keys.SETTINGS_ANDROID_NOTIFICATION_MSG,
                        map[Keys.SETTINGS_ANDROID_NOTIFICATION_MSG] as String
                    )
                    .apply()
            }

            if (map[Keys.SETTINGS_ANDROID_NOTIFICATION_BIG_MSG] is String) {
                sharedPreferences.edit()
                    .putString(
                        Keys.SETTINGS_ANDROID_NOTIFICATION_BIG_MSG,
                        map[Keys.SETTINGS_ANDROID_NOTIFICATION_BIG_MSG] as String
                    )
                    .apply()
            }

            if (map[Keys.SETTINGS_ANDROID_NOTIFICATION_BIG_MSG] is String) {
                sharedPreferences.edit()
                    .putString(
                        Keys.SETTINGS_ANDROID_NOTIFICATION_ICON,
                        map[Keys.SETTINGS_ANDROID_NOTIFICATION_ICON] as String
                    )
                    .apply()
            }

            if (map[Keys.SETTINGS_ANDROID_NOTIFICATION_ICON_COLOR] is Long) {
                sharedPreferences.edit()
                    .putLong(
                        Keys.SETTINGS_ANDROID_NOTIFICATION_ICON_COLOR,
                        map[Keys.SETTINGS_ANDROID_NOTIFICATION_ICON_COLOR] as Long
                    )
                    .apply()
            }

            if (map[Keys.SETTINGS_INTERVAL] is Int) {
                sharedPreferences.edit()
                    .putInt(
                        Keys.SETTINGS_INTERVAL,
                        map[Keys.SETTINGS_INTERVAL] as Int
                    )
                    .apply()
            }

            if (map[Keys.SETTINGS_ACCURACY] is Int) {
                sharedPreferences.edit()
                    .putInt(
                        Keys.SETTINGS_ACCURACY,
                        map[Keys.SETTINGS_ACCURACY] as Int
                    )
                    .apply()
            }

            if (map[Keys.SETTINGS_DISTANCE_FILTER] is Double || map[Keys.SETTINGS_DISTANCE_FILTER] is Float) {
                sharedPreferences.edit()
                    .putFloat(
                        Keys.SETTINGS_DISTANCE_FILTER,
                        (map[Keys.SETTINGS_DISTANCE_FILTER] as Double).toFloat()
                    )
                    .apply()
            }

            if (map[Keys.SETTINGS_ANDROID_WAKE_LOCK_TIME] is Int) {
                sharedPreferences.edit()
                    .putInt(
                        Keys.SETTINGS_ANDROID_WAKE_LOCK_TIME,
                        map[Keys.SETTINGS_ANDROID_WAKE_LOCK_TIME] as Int
                    )
                    .apply()
            }

            if (map[Keys.SETTINGS_ANDROID_LOCATION_CLIENT] is Int) {
                sharedPreferences.edit()
                    .putInt(
                        Keys.SETTINGS_ANDROID_LOCATION_CLIENT,
                        map[Keys.SETTINGS_ANDROID_LOCATION_CLIENT] as Int
                    )
                    .apply()
            }
        }

        @JvmStatic
        fun getSettings(context: Context): Map<Any, Any?> {
            val sharedPreferences =
                context.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE)

            val result = HashMap<Any, Any?>()

            result[Keys.ARG_CALLBACK_DISPATCHER] =
                sharedPreferences.getLong(Keys.ARG_CALLBACK_DISPATCHER, 0)

            if (sharedPreferences.contains(Keys.ARG_NOTIFICATION_CALLBACK)) {
                result[Keys.ARG_NOTIFICATION_CALLBACK] =
                    sharedPreferences.getLong(Keys.ARG_NOTIFICATION_CALLBACK, 0)
            }

            result[Keys.SETTINGS_ANDROID_NOTIFICATION_CHANNEL_NAME] =
                sharedPreferences.getString(Keys.SETTINGS_ANDROID_NOTIFICATION_CHANNEL_NAME, "")

            result[Keys.SETTINGS_ANDROID_NOTIFICATION_TITLE] =
                sharedPreferences.getString(Keys.SETTINGS_ANDROID_NOTIFICATION_TITLE, "")

            result[Keys.SETTINGS_ANDROID_NOTIFICATION_MSG] =
                sharedPreferences.getString(Keys.SETTINGS_ANDROID_NOTIFICATION_MSG, "")

            result[Keys.SETTINGS_ANDROID_NOTIFICATION_BIG_MSG] =
                sharedPreferences.getString(Keys.SETTINGS_ANDROID_NOTIFICATION_BIG_MSG, "")

            result[Keys.SETTINGS_ANDROID_NOTIFICATION_ICON] =
                sharedPreferences.getString(Keys.SETTINGS_ANDROID_NOTIFICATION_ICON, "")

            result[Keys.SETTINGS_ANDROID_NOTIFICATION_ICON_COLOR] =
                sharedPreferences.getLong(Keys.SETTINGS_ANDROID_NOTIFICATION_ICON_COLOR, 0)

            result[Keys.SETTINGS_INTERVAL] =
                sharedPreferences.getInt(Keys.SETTINGS_INTERVAL, 0)

            result[Keys.SETTINGS_ACCURACY] =
                sharedPreferences.getInt(Keys.SETTINGS_ACCURACY, 0)

            result[Keys.SETTINGS_DISTANCE_FILTER] =
                sharedPreferences.getFloat(Keys.SETTINGS_DISTANCE_FILTER, 0f).toDouble()

            if (sharedPreferences.contains(Keys.SETTINGS_ANDROID_WAKE_LOCK_TIME)) {
                result[Keys.SETTINGS_ANDROID_WAKE_LOCK_TIME] =
                    sharedPreferences.getInt(Keys.SETTINGS_ANDROID_WAKE_LOCK_TIME, 0)
            }

            result[Keys.SETTINGS_NETWORK_URL] =
                sharedPreferences.getString(Keys.SETTINGS_NETWORK_URL, "")
            result[Keys.SETTINGS_NETWORK_METHOD] =
                sharedPreferences.getString(Keys.SETTINGS_NETWORK_METHOD, "POST")

            result[Keys.SETTINGS_NETWORK_HEADERS] = sharedPreferences.getString(
                    Keys.SETTINGS_NETWORK_HEADERS,
                    "{}"
                )

            result[Keys.SETTINGS_ANDROID_LOCATION_CLIENT] =
                sharedPreferences.getInt(Keys.SETTINGS_ANDROID_LOCATION_CLIENT, 0)
            Log.d("LOCATION", "Get Setting: $result")
            return result
        }

        @JvmStatic
        fun getLocationClient(context: Context): LocationClient {
            val sharedPreferences =
                context.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE)
            val client = sharedPreferences.getInt(Keys.SETTINGS_ANDROID_LOCATION_CLIENT, 0)
            return LocationClient.fromInt(client) ?: LocationClient.Google
        }

        @JvmStatic
        fun setCallbackHandle(context: Context, key: String, handle: Long?) {
            if (handle == null) {
                context.getSharedPreferences(Keys.SHARED_PREFERENCES_KEY, Context.MODE_PRIVATE)
                    .edit()
                    .remove(key)
                    .apply()
                return
            }

            context.getSharedPreferences(Keys.SHARED_PREFERENCES_KEY, Context.MODE_PRIVATE)
                .edit()
                .putLong(key, handle)
                .apply()
        }

        @JvmStatic
        fun setDataCallback(context: Context, key: String, data: Map<*, *>?) {
            if (data == null) {
                context.getSharedPreferences(Keys.SHARED_PREFERENCES_KEY, Context.MODE_PRIVATE)
                    .edit()
                    .remove(key)
                    .apply()
                return
            }
            val dataStr = Gson().toJson(data)
            context.getSharedPreferences(Keys.SHARED_PREFERENCES_KEY, Context.MODE_PRIVATE)
                .edit()
                .putString(key, dataStr)
                .apply()
        }

        @JvmStatic
        fun getCallbackHandle(context: Context, key: String): Long? {
            val sharedPreferences =
                context.getSharedPreferences(Keys.SHARED_PREFERENCES_KEY, Context.MODE_PRIVATE)
            if (sharedPreferences.contains(key)) return sharedPreferences.getLong(key, 0L)
            return null
        }

        @JvmStatic
        fun getDataCallback(context: Context, key: String): Map<*, *> {
            val initialDataStr =
                context.getSharedPreferences(Keys.SHARED_PREFERENCES_KEY, Context.MODE_PRIVATE)
                    .getString(key, null)
            val type = object : TypeToken<Map<*, *>>() {}.type
            return Gson().fromJson(initialDataStr, type)
        }
    }
}