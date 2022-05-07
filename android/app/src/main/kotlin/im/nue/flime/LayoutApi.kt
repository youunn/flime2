package im.nue.flime

class LayoutApi(val flime: Flime) : Pigeon.LayoutApi {
    override fun updateHeight(height: Long) {
        if (flime.inputViewHeight != height.toInt()) {
            flime.inputViewHeight = height.toInt()
            flime.inputView.requestLayout()
        }
    }
}