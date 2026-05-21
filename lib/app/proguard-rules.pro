# =========================
# GOOGLE ML KIT
# =========================

-keep class com.google.mlkit.** { *; }
-dontwarn com.google.mlkit.**

# =========================
# TEXT RECOGNITION
# =========================

-keep class com.google.android.gms.internal.mlkit_vision_text_common.** { *; }

-keep class com.google.android.gms.internal.mlkit_vision_common.** { *; }

# =========================
# MLKIT LANGUAGE OPTIONS
# =========================

-keep class com.google.mlkit.vision.text.chinese.** { *; }

-keep class com.google.mlkit.vision.text.devanagari.** { *; }

-keep class com.google.mlkit.vision.text.japanese.** { *; }

-keep class com.google.mlkit.vision.text.korean.** { *; }

# =========================
# IMAGE PICKER
# =========================

-keep class io.flutter.plugins.imagepicker.** { *; }

# =========================
# GETX
# =========================

-keep class com.example.** { *; }