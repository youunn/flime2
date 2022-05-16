package im.nue.flime

import android.content.Context
import android.content.Intent
import android.inputmethodservice.InputMethodService
import android.provider.Settings
import android.view.inputmethod.InputMethodManager

class InputMethodApi(private val context: Context) : Pigeon.InputMethodApi {
    override fun enable() {
        Intent().apply {
            action = Settings.ACTION_INPUT_METHOD_SETTINGS
            addCategory(Intent.CATEGORY_DEFAULT)
            context.startActivity(this)
        }
    }

    override fun pick() {
        val manager = context.getSystemService(InputMethodService.INPUT_METHOD_SERVICE) as InputMethodManager
        manager.showInputMethodPicker()
    }
}