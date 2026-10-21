# Mac mode (idea, not implemented)

The keymap is tuned for Windows with a UK layout. This note records what breaks on a Mac
and the plan for a Mac layer, so it can be picked up later. Nothing here is built or tested.

## What breaks on macOS

**Shortcut modifiers (Cmd, not Ctrl)**

| Windows behaviour | Mac equivalent |
|---|---|
| Left outer thumb = Ctrl (all layers) | Cmd |
| Hold Z/X/C/V on BASE = Ctrl+Z/X/C/V (`cs` hold-tap) | Cmd+Z/X/C/V |
| SYM Z/X/C/V/B = Ctrl+Z/X/C/V/B | Cmd+... |
| Ctrl+Q sends Alt+F4 (`qq` mod-morph) | plain Cmd+Q, no morph |
| SYM + Tab swapper holds Alt (`swap`) | Cmd+Tab (hold Cmd) |
| ADJ Z = Win+L lock | Ctrl+Cmd+Q |
| SYM V double-tap = Win+V clipboard history (`pv`) | no native equivalent |
| NAV left outer thumb one-shot Win (`&sk LGUI`) | sends Cmd; Win-style shortcuts don't exist |
| Right thumb Alt | Option (also types accents, handy on Mac) |
| NAV Home / End | Cmd+Left / Cmd+Right (line), or Cmd+Up / Cmd+Down (document) |
| NAV word jumps (Ctrl+Left/Right) | Option+Left / Option+Right |

**Symbols.** The key codes for `\`, `|`, `#` and the backtick/tilde key (`NUBS`, `NUHS`, `GRAVE`)
land on different characters on a UK Mac layout. On a UK Mac the `` ` ~ `` key is the one next
to Z (the key code currently used as `\` on SYM). Needs checking on a real Mac. macOS's
Keyboard Setup Assistant (ISO vs ANSI choice when pairing) also changes what these produce.

**Navigation (NAV layer).** Home/End (top row, above the word-jump keys) go to the document
start/end on macOS. The Mac line start/end is Cmd+Left/Right, and the document start/end is
Cmd+Up/Down. The word-jump keys (home row, either side of Up) send Ctrl+Left/Right, which on a
Mac should be Option+Left/Right. Held with Shift, both extend the selection the same way.

**Trackpad.** Swipe and zoom shortcuts are selected at build time by `TOUCAN_WIN_MODE` in
`boards/shields/toucan/toucan.dtsi` (it is defined now). The Mac variants are already in that
file. Scroll and pointer speed probably need retuning for macOS acceleration.

Same on both: Bluetooth profiles, numpad, F keys, media/volume keys, mouse back/forward,
Space/Enter as Shift.

## Plan

1. Add a `MAC` layer toggled by a key (ADJ, somewhere not easy to hit by accident) that overrides
   about ten keys with the Mac versions from the table above.
2. Fix the symbol keys on that layer once the real behaviour is checked on a UK Mac.
3. Trackpad gestures: either leave them (Windows variants) or build a second left-half firmware
   without `TOUCAN_WIN_MODE` through an extra `build.yaml` entry.

## Open questions

- Does the toggled layer survive a power-off? Believed not, in which case the keyboard starts in
  Windows mode and needs toggling after a full restart. Not checked.
- Is one firmware (toggle) or two firmwares (Windows / Mac) better for how often you switch?
- Which key should toggle it?
