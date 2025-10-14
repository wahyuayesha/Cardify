# ==== Google ML Kit Rules ====
-keep class com.google.mlkit.** { *; }
-dontwarn com.google.mlkit.**

# ==== Google Play Core (splitinstall) ====
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**

# ==== Flutter SplitCompat (Play Store features) ====
-keep class io.flutter.embedding.engine.deferredcomponents.** { *; }
-dontwarn io.flutter.embedding.engine.deferredcomponents.**

# ==== Prevent R8 from removing Parcelable & Serializable models ====
-keepclassmembers class * implements android.os.Parcelable {
    public static final ** CREATOR;
}
-keepclassmembers class * implements java.io.Serializable { *; }

# ==== Keep MLKit Internal Builders ====
-keepclassmembers class * {
    *** Builder();
}

# ==== General ====
-dontwarn androidx.lifecycle.**
-dontwarn kotlinx.coroutines.**
