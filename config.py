# -*- coding: utf-8 -*-

import re
from xkeysnail.transform import *

# define timeout for multipurpose_modmap
define_timeout(1)

# [Global modemap] Change modifier keys as in xmodmap
define_modmap({
    Key.CAPSLOCK: Key.LEFT_CTRL
})

# [Conditional modmap] Change modifier keys in certain applications
define_conditional_modmap(re.compile(r'Emacs'), {
    Key.RIGHT_CTRL: Key.ESC,
})

# [Multipurpose modmap] Give a key two meanings. A normal key when pressed and
# released, and a modifier key when held down with another key. See Xcape,
# Carabiner and caps2esc for ideas and concept.
define_multipurpose_modmap(
    # Enter is enter when pressed and released. Control when held down.
    {Key.ENTER: [Key.ENTER, Key.RIGHT_CTRL]}

    # Capslock is escape when pressed and released. Control when held down.
    # {Key.CAPSLOCK: [Key.ESC, Key.LEFT_CTRL]
    # To use this example, you can't remap capslock with define_modmap.
)

# [Conditional multipurpose modmap] Multipurpose modmap in certain conditions,
# such as for a particular device.
define_conditional_multipurpose_modmap(lambda wm_class, device_name: device_name.startswith("Microsoft"), {
   # Left shift is open paren when pressed and released.
   # Left shift when held down.
   Key.LEFT_SHIFT: [Key.KPLEFTPAREN, Key.LEFT_SHIFT],

   # Right shift is close paren when pressed and released.
   # Right shift when held down.
   Key.RIGHT_SHIFT: [Key.KPRIGHTPAREN, Key.RIGHT_SHIFT]
})


# Keybindings for Firefox/Chrome
define_keymap(re.compile("Firefox|Google-chrome"), {
    # Ctrl+Alt+j/k to switch next/previous tab
    #K("C-M-j"): K("C-TAB"),
    #K("C-M-k"): K("C-Shift-TAB"),
    # Type C-j to focus to the content
    #K("C-j"): K("C-f6"),
    # very naive "Edit in editor" feature (just an example)
    #K("C-o"): [K("C-a"), K("C-c"), launch(["gedit"]), sleep(0.5), K("C-v")]
}, "Firefox and Chrome")

# Keybindings for Zeal https://github.com/zealdocs/zeal/
define_keymap(re.compile("Zeal"), {
    # Ctrl+s to focus search area
    #K("C-s"): K("C-k"),
}, "Zeal")

# Emacs-like keybindings in non-Emacs applications
define_keymap(lambda wm_class: wm_class not in ("Emacs", "URxvt"), {
    # Cursor
    K("C-j"): with_mark(K("left")),
    K("C-l"): with_mark(K("right")),
    K("C-i"): with_mark(K("up")),
    K("C-k"): with_mark(K("down")),

    # Beginning/End of line
    K("C-u"): with_mark(K("home")),
    K("C-o"): with_mark(K("end")),

    # Page up/down
    K("C-h"): with_mark(K("page_up")),
    K("C-n"): with_mark(K("page_down")),

    # Delete
    K("C-Backspace"): [K("delete"), set_mark(False)],
    # K("C-M-Backspace"): [K("C-delete"), set_mark(False)]

    # Teclas F
    K("C-KEY_1"): with_mark(K("F1")),
    K("C-KEY_2"): with_mark(K("F2")),
    K("C-KEY_3"): with_mark(K("F3")),
    K("C-KEY_4"): with_mark(K("F4")),
    K("C-KEY_5"): with_mark(K("F5")),
    K("C-KEY_6"): with_mark(K("F6")),
    K("C-KEY_7"): with_mark(K("F7")),
    K("C-KEY_8"): with_mark(K("F8")),
    K("C-KEY_9"): with_mark(K("F9")),
    K("C-KEY_0"): with_mark(K("F10")),
    K("C-MINUS"): with_mark(K("F11")),
    K("C-EQUAL"): with_mark(K("F12")),
}, "Emacs-like keys")
