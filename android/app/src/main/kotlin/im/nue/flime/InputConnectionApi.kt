package im.nue.flime

import android.inputmethodservice.InputMethodService
import android.os.SystemClock
import android.view.InputDevice
import android.view.KeyCharacterMap
import android.view.KeyEvent

class InputConnectionApi(private val inputMethodService: InputMethodService) :
    Pigeon.InputConnectionApi {
    private var _actionId: Long = 0
    fun setActionId (actionId: Int) {
        _actionId = actionId.toLong()
    }

    override fun commit(text: String) {
        inputMethodService.currentInputConnection.commitText(text, 1)
    }

    override fun send(code: Long, mask: Long) {
        inputMethodService.currentInputConnection.clearMetaKeyStates(
            KeyEvent.META_FUNCTION_ON
                    or KeyEvent.META_SHIFT_MASK
                    or KeyEvent.META_ALT_MASK
                    or KeyEvent.META_CTRL_MASK
                    or KeyEvent.META_META_MASK
                    or KeyEvent.META_SYM_ON
        )
        inputMethodService.currentInputConnection.beginBatchEdit()
        val eventTime = SystemClock.uptimeMillis()
        for (action in listOf(KeyEvent.ACTION_DOWN, KeyEvent.ACTION_UP)) {
            inputMethodService.currentInputConnection.sendKeyEvent(
                KeyEvent(
                    eventTime,
                    SystemClock.uptimeMillis(),
                    action,
                    code.toInt(),
                    0,
                    mask.toInt(),
                    KeyCharacterMap.VIRTUAL_KEYBOARD,
                    0,
                    KeyEvent.FLAG_SOFT_KEYBOARD or KeyEvent.FLAG_KEEP_TOUCH_MODE,
                    InputDevice.SOURCE_KEYBOARD,
                )
            )
        }
        inputMethodService.currentInputConnection.endBatchEdit()
    }

    override fun performEnter() {
        inputMethodService.sendKeyChar('\n');
    }

    override fun handleBack() {
        inputMethodService.requestHideSelf(0)
    }

    override fun getActionId(): Long {
        return _actionId;
    }
}
