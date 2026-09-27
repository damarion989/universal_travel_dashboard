## Phase 1

ThemeData seems convenient because it keeps the colors and text styles in one place. I can reuse the same styles instead of setting them on every widget.

It seems complicated because it has a lot of settings, and I need to know which one controls the widget I want to change.

## Phase 2

When designing breakpoints, I need to think about the amount of available space for the navigation and content instead of only thinking about the device type. MediaQuery can check the screen width for different layouts. It can also give information about the height, padding, and text scaling.

## Phase 3

LayoutBuilder is used here because it checks the available space inside the content area. MediaQuery checks the whole window. The desktop navigation takes up some of the window space, so LayoutBuilder gives a better measurement for deciding between the grid and list.

## Phase 4

I would prefer using ThemeData for a specialized widget because it keeps the colors connected to the rest of the app. Hard-coding values is faster for one widget, but it would be harder to change later and could make the app look inconsistent.