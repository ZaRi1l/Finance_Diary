import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.trade.trading_diary"
    compileSdk = 36
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    defaultConfig {
        applicationId = "com.trade.trading_diary"
        minSdk = flutter.minSdkVersion
        targetSdk = 36
        versionCode = 3
        versionName = "3.0"
    }

    signingConfigs {
        create("release") {
            val keyProperties = Properties()
            // 경로를 현재 build.gradle.kts 파일의 상위 폴더(android)에서 찾도록 수정합니다.
            val keyPropertiesFile = project.parent?.file("key.properties")

            if (keyPropertiesFile != null && keyPropertiesFile.exists()) {
                keyProperties.load(keyPropertiesFile.inputStream())

                keyAlias = keyProperties.getProperty("keyAlias")
                keyPassword = keyProperties.getProperty("keyPassword")
                storePassword = keyProperties.getProperty("storePassword")

                val storeFileName = keyProperties.getProperty("storeFile")
                if (storeFileName != null) {
                    // 키스토어 파일도 같은 위치에서 찾습니다.
                    storeFile = project.parent?.file(storeFileName)
                }
            } else {
                // 파일을 못 찾을 경우, 터미널에 메시지를 출력합니다.
                println("!!! 경고: 'android' 폴더에서 key.properties 파일을 찾을 수 없습니다. !!!")
                // 서명 없이 빌드를 시도하도록 빈 값을 설정합니다 (이렇게 하면 서명 오류가 뜹니다)
                storeFile = null
                storePassword = ""
                keyAlias = ""
                keyPassword = ""
            }
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

flutter {
    source = "../.."
}
