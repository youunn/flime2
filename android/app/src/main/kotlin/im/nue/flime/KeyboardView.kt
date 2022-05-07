package im.nue.flime

import android.content.Context
import android.util.AttributeSet
import android.view.ViewGroup
import androidx.constraintlayout.widget.ConstraintLayout
import io.flutter.embedding.android.FlutterView

class KeyboardView(context: Context, attrs: AttributeSet) : ConstraintLayout(context, attrs) {
    private val placer = ConstraintLayout(context, attrs)

    lateinit var flutterView: FlutterView

    override fun onAttachedToWindow() {
        super.onAttachedToWindow()

        val content = rootView.findViewById<ViewGroup>(android.R.id.content)
        content.addView(placer)

        flutterView.layoutParams = LayoutParams(
            LayoutParams.MATCH_PARENT,
            LayoutParams.WRAP_CONTENT,
        ).apply {
            bottomToBottom = LayoutParams.PARENT_ID
            bottomMargin = 0
        }
        placer.addView(flutterView)
    }

    fun removeFlutterView() {
        placer.removeView(flutterView)
    }
}
