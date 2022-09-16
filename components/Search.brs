sub init()
  m.top.textEditBox.voiceEntryType = "generic"
  m.top.observeField("vertical_clipping_rect", "changeClippingRect")
end sub

sub changeClippingRect()
  m.top.clippingRect = [0.0, 0.0, 1920.0, m.top.vertical_clipping_rect]
end sub