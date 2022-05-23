package im.nue.flime

import android.content.res.Configuration
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
    private var inputConnectionApi: InputConnectionApi? = null
    private var inputServiceApi: Pigeon.InputServiceApi? = null

    var inputViewHeight = 0
    var fullScreenMode = false
    val inputView get() = binding.root

    companion object {
        private const val LIBRARY_NAME = "package:flime/main.dart"
        private const val SHOW_KEYBOARD_ENTRY_POINT = "showKeyboard"
    }

    override fun onCreate() {
        super.onCreate()
        binding = KeyboardBinding.inflate(layoutInflater)

        engine = FlutterEngine(this)
        engine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint(
                FlutterInjector.instance().flutterLoader().findAppBundlePath(),
                LIBRARY_NAME,
                SHOW_KEYBOARD_ENTRY_POINT,
            )
        )

        Pigeon.LayoutApi.setup(
            engine.dartExecutor.binaryMessenger,
            LayoutApi(this),
        )
        inputConnectionApi = InputConnectionApi(this)
        Pigeon.InputConnectionApi.setup(
            engine.dartExecutor.binaryMessenger,
            inputConnectionApi,
        )
        Pigeon.InputMethodApi.setup(
            engine.dartExecutor.binaryMessenger,
            InputMethodApi(this),
        )
        inputServiceApi = Pigeon.InputServiceApi(engine.dartExecutor.binaryMessenger)
    }

    override fun onEvaluateFullscreenMode(): Boolean {
        val config = resources.configuration
        if (config.orientation != Configuration.ORIENTATION_LANDSCAPE) {
            return false
        }
        return if (fullScreenMode) true
        else super.onEvaluateFullscreenMode()
    }

    override fun onCreateInputView(): View {
        engine.serviceControlSurface.attachToService(this, null, true)
        flutterView = FlutterView(this, FlutterSurfaceView(this, true))
        flutterView.attachToFlutterEngine(engine)
        inputView.flutterView = flutterView

        return inputView
    }

    override fun onStartInputView(info: EditorInfo?, restarting: Boolean) {
        super.onStartInputView(info, restarting)
        updateHeight()
        engine.lifecycleChannel.appIsResumed()
        inputConnectionApi?.setActionId((info?.imeOptions ?: 0) and EditorInfo.IME_MASK_ACTION)
        inputServiceApi?.startInputView { }
    }

    override fun onFinishInputView(finishingInput: Boolean) {
        super.onFinishInputView(finishingInput)
        engine.lifecycleChannel.appIsPaused()
    }

    override fun setInputView(view: View?) {
        (view?.parent as ViewGroup?)?.removeView(view)
        super.setInputView(view)
        if (view == null) return
    }

    override fun onComputeInsets(outInsets: Insets?) {
        super.onComputeInsets(outInsets)

        // TODO: val touchTop = if (showingMoreKeys) 0 else visibleTopY
        outInsets?.touchableInsets = Insets.TOUCHABLE_INSETS_REGION
        val outInsetsTop = inputView.height - inputViewHeight
        outInsets?.touchableRegion?.set(0, outInsetsTop, inputView.width, inputView.height)
        outInsets?.contentTopInsets = outInsetsTop
        outInsets?.visibleTopInsets = outInsetsTop
    }

    override fun onDestroy() {
        super.onDestroy()
        if (::flutterView.isInitialized) {
            inputView.removeFlutterView()
            flutterView.detachFromFlutterEngine()
        }
        if (::engine.isInitialized) engine.run {
            inputServiceApi?.finalize {}
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
