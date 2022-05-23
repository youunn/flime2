package im.nue.flime

class LayoutApi(private val flime: Flime) : Pigeon.LayoutApi {
    override fun updateHeight(height: Long) {
        if (flime.inputViewHeight != height.toInt()) {
            flime.inputViewHeight = height.toInt()
            flime.inputView.requestLayout()
        }
    }

    override fun toggleFullScreen() {
        flime.fullScreenMode = !flime.fullScreenMode;
        flime.updateFullscreenMode()
        flime.requestHideSelf(0)
    }
}