package im.nue.flime

import android.inputmethodservice.InputMethodService
import android.view.*
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
    private var insetsUpdater: InsetsUpdater? = null

    var inputViewHeight = 0
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

        Pigeon.LayoutApi.setup(engine.dartExecutor.binaryMessenger, LayoutApi(this))
    }

    override fun onCreateInputView(): View {
        engine.serviceControlSurface.attachToService(this, null, true)
        flutterView = FlutterView(this, FlutterSurfaceView(this, true))
        flutterView.attachToFlutterEngine(engine)
        inputView.flutterView = flutterView

        return inputView
    }

    override fun setInputView(view: View?) {
        super.setInputView(view)
        if (view == null) return
        insetsUpdater = InsetsUpdater(view)
    }

    override fun onComputeInsets(outInsets: Insets?) {
        super.onComputeInsets(outInsets)

        // val touchTop = if (showingMoreKeys) 0 else visibleTopY
        outInsets?.touchableInsets = Insets.TOUCHABLE_INSETS_REGION
        val outInsetsTop = inputView.height - inputViewHeight
        outInsets?.touchableRegion?.set(0, outInsetsTop, inputView.width, inputView.height)
        outInsets?.contentTopInsets = outInsetsTop
        outInsets?.visibleTopInsets = outInsetsTop
        insetsUpdater?.setInsets(outInsets)
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
