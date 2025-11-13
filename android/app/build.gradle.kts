plugins {
    id("com.android.application")
    id("kotlin-android")

    // ✅ FlutterFire Configuration (Firebase)
    id("com.google.gms.google-services")

    // ✅ The Flutter Gradle Plugin must be applied last
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.storeapp"
    compileSdk = flutter.compileSdkVersion

    // ✅ Use highest compatible NDK version for Firebase dependencies
    ndkVersion = "27.0.12077973"

    compileOptions {
        // ✅ Modern Java version (fixes old warnings)
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // ✅ Unique app ID
        applicationId = "com.example.storeapp"

        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Replace with your own signing config for release builds
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
