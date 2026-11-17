// Firefox prefs (Linux profile only). Applied on every Firefox start.
// Note: user.js is NOT JavaScript -- only user_pref(...) lines are allowed.

// Use the Nerd Font for every default font family.
user_pref("font.name.sans-serif.x-western", "JetBrainsMono Nerd Font");
user_pref("font.name.serif.x-western", "JetBrainsMono Nerd Font");
user_pref("font.name.monospace.x-western", "JetBrainsMono Nerd Font");
user_pref("font.name.sans-serif.x-unicode", "JetBrainsMono Nerd Font");
user_pref("font.name.serif.x-unicode", "JetBrainsMono Nerd Font");
user_pref("font.name.monospace.x-unicode", "JetBrainsMono Nerd Font");
user_pref("font.default.x-western", "sans-serif");
user_pref("font.default.x-unicode", "sans-serif");

// Ignore fonts chosen by websites (e.g. Gmail's Google Sans / Roboto).
// Known icon fonts (Material Icons/Symbols, Font Awesome) are still allowed via
// browser.display.use_document_fonts.icon_font_allowlist, so icons keep working.
user_pref("browser.display.use_document_fonts", 0);

// Load chrome/userChrome.css + chrome/userContent.css (dotfiles colour palette).
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Dark everywhere: Firefox UI, its own pages, and sites that support dark mode.
user_pref("ui.systemUsesDarkTheme", 1);
user_pref("browser.theme.toolbar-theme", 0);
user_pref("browser.theme.content-theme", 0);
user_pref("layout.css.prefers-color-scheme.content-override", 0);

// Palette for unstyled pages and blank tabs while loading.
user_pref("browser.display.background_color.dark", "#0d1117");
user_pref("browser.display.foreground_color.dark", "#c9d1d9");
user_pref("browser.anchor_color.dark", "#58a6ff");
user_pref("browser.visited_color.dark", "#db61a2");
