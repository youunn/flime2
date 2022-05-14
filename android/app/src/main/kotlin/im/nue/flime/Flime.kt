package im.nue.flime

import android.inputmethodservice.InputMethodService
import android.view.Gravity
import android.view.View
import android.view.ViewGroup
import android.view.WindowManager
import android.view.inputmethod.EditorInfo
import android.widget.FrameLayout
import android.widget.LinearLayout
import androidx.core.view.updateLayoutParams
import im.nue.flime.databinding.KeyboardBinding
import io.flutter.FlutterInjector
import io.flutter.embedding.android.FlutterSurfaceView
import io.flutter.embedding.android.FlutterView
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor

class Flime : InputMethodService() {
    private lateinit var engine: FlutterEngine
    private lateinit var flutterView: FlutterView
    private lateinit var binding: KeyboardBinding

    var inputViewHeight = 0
    val inputView get() = binding.root

    companion object {
        private const val LIBRARY_NAME = "package:flime/main.dart"
        private const val SHOW_KEYBOARD_ENTRY_POINT = "showKeyboard"
    }

    override fun onCreate() {
        super.onCreate()
        binding = KeyboardBinding.inflate(layoutInflater)
    }

    override fun onCreateInputView(): View {
        engine = FlutterEngine(this)
        engine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint(
                FlutterInjector.instance().flutterLoader().findAppBundlePath(),
                LIBRARY_NAME,
                SHOW_KEYBOARD_ENTRY_POINT,
            )
        )
        engine.serviceControlSurface.attachToService(this, null, true)
        flutterView = FlutterView(this, FlutterSurfaceView(this, true))
        flutterView.attachToFlutterEngine(engine)
        inputView.flutterView = flutterView

        Pigeon.LayoutApi.setup(engine.dartExecutor.binaryMessenger, LayoutApi(this))

        return inputView
    }

    override fun onComputeInsets(outInsets: Insets?) {
        super.onComputeInsets(outInsets)
        outInsets?.visibleTopInsets = inputView.height - inputViewHeight
        outInsets?.contentTopInsets = inputView.height - inputViewHeight
    }

    override fun onStartInputView(info: EditorInfo?, restarting: Boolean) {
        super.onStartInputView(info, restarting)
        updateHeight()
        engine.lifecycleChannel.appIsResumed()
    }

    override fun onFinishInputView(finishingInput: Boolean) {
        super.onFinishInputView(finishingInput)
        engine.lifecycleChannel.appIsPaused()
    }

    override fun onDestroy() {
        super.onDestroy()
        if (::flutterView.isInitialized) {
            inputView.removeFlutterView()
            flutterView.detachFromFlutterEngine()
        }
        if (::engine.isInitialized) engine.run {
            serviceControlSurface.detachFromService()
            lifecycleChannel.appIsDetached()
            destroy()
        }
    }

    private fun updateHeight() {
        window.window?.attributes?.let {
            if (it.height != WindowManager.LayoutParams.MATCH_PARENT) {
                it.height = WindowManager.LayoutParams.MATCH_PARENT
                window.window?.attributes = it
            }
        }

        val layoutHeight =
            if (isFullscreenMode)
                ViewGroup.LayoutParams.WRAP_CONTENT
            else
                ViewGroup.LayoutParams.MATCH_PARENT

        val inputArea = window.findViewById<View>(android.R.id.inputArea)
        inputArea.updateLayoutParams {
            height = layoutHeight
        }

        if (inputArea.layoutParams is LinearLayout.LayoutParams) {
            inputArea.updateLayoutParams<LinearLayout.LayoutParams> {
                gravity = Gravity.BOTTOM
            }
        } else if (inputArea.layoutParams is FrameLayout.LayoutParams) {
            inputArea.updateLayoutParams<FrameLayout.LayoutParams> {
                gravity = Gravity.BOTTOM
            }
        }

        inputView.updateLayoutParams {
            height = layoutHeight
        }
    }
}
