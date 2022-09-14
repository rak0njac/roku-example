sub init()
  m.top.observeField("vertical_clipping_rect", "changeClippingRect")
end sub

sub changeClippingRect()
  m.top.clippingRect = [0.0, 0.0, 1280.0, m.top.vertical_clipping_rect]
end sub