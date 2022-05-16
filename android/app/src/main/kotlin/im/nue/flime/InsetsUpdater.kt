package im.nue.flime

import android.graphics.Outline
import android.inputmethodservice.InputMethodService
import android.view.View
import android.view.ViewOutlineProvider

class InsetsUpdater(private val view: View?) : ViewOutlineProvider() {
    private var lastVisibleTopInsets = -1

    init {
        view?.outlineProvider = this
    }

    fun setInsets(insets: InputMethodService.Insets?) {
        if (insets == null) return
        val visibleTopInsets = insets.visibleTopInsets
        if (lastVisibleTopInsets != visibleTopInsets) {
            lastVisibleTopInsets = visibleTopInsets
            view?.invalidateOutline()
        }
    }

    override fun getOutline(view: View, outline: Outline) {
        if (lastVisibleTopInsets == -1) {
            BACKGROUND.getOutline(view, outline)
            return
        }
        outline.setRect(
            view.left, lastVisibleTopInsets, view.right, view.bottom
        )
    }
}