cmake_minimum_required(VERSION 3.15)
project(launcher Java)
find_package(Java 1.7 REQUIRED COMPONENTS Development)

include(UseJava)
set(CMAKE_JAVA_JAR_ENTRY_POINT org.penguinlauncher.EntryPoint)
set(CMAKE_JAVA_COMPILE_FLAGS -target 7 -source 7)

set(SRC
    org/penguinlauncher/EntryPoint.java
    org/penguinlauncher/launcher/Launcher.java
    org/penguinlauncher/launcher/impl/AbstractLauncher.java
    org/penguinlauncher/launcher/impl/StandardLauncher.java
    org/penguinlauncher/exception/ParameterNotFoundException.java
    org/penguinlauncher/exception/ParseException.java
    org/penguinlauncher/utils/Parameters.java
    org/penguinlauncher/utils/ReflectionUtils.java
    org/penguinlauncher/utils/logging/Level.java
    org/penguinlauncher/utils/logging/Log.java
    org/penguinlauncher/legacy/LegacyProxy.java
)

set(LEGACY_SRC
    legacy/org/penguinlauncher/legacy/LegacyFrame.java
    legacy/org/penguinlauncher/legacy/LegacyLauncher.java
    legacy/org/penguinlauncher/legacy/fix/online/Handler.java
    legacy/org/penguinlauncher/legacy/fix/online/OnlineFixes.java
    legacy/org/penguinlauncher/legacy/fix/online/OnlineModeFix.java
    legacy/org/penguinlauncher/legacy/fix/online/SkinFix.java
    legacy/org/penguinlauncher/legacy/utils/Base64.java
    legacy/org/penguinlauncher/legacy/utils/api/MojangApi.java
    legacy/org/penguinlauncher/legacy/utils/api/Texture.java
    legacy/org/penguinlauncher/legacy/utils/json/JsonParseException.java
    legacy/org/penguinlauncher/legacy/utils/json/JsonParser.java
    legacy/org/penguinlauncher/legacy/utils/url/ByteArrayUrlConnection.java
    legacy/org/penguinlauncher/legacy/utils/url/UrlUtils.java
    legacy/net/minecraft/Launcher.java
    legacy/org/penguinlauncher/legacy/LegacyProxy.java
)

add_jar(NewLaunch ${SRC})
add_jar(NewLaunchLegacy ${LEGACY_SRC} INCLUDE_JARS NewLaunch)
install_jar(NewLaunch "${JARS_DEST_DIR}")
install_jar(NewLaunchLegacy "${JARS_DEST_DIR}")
