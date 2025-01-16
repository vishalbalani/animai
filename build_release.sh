#!/bin/bash

# Initialize verbose flag
VERBOSE=false

# Parse command line arguments
while getopts "v" opt; do
    case $opt in
        v)
            VERBOSE=true
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
    esac
done

# Function to execute command with or without verbose output
run_command() {
    if [ "$VERBOSE" = true ]; then
        "$@"
    else
        "$@" > /dev/null 2>&1
    fi
}

# Function to print status
print_status() {
    if [ "$2" = "error" ]; then
        echo "❌ $1"
    else
        echo "$1"
    fi
}

# Function to print section header
print_section() {
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "🚀 $1"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
}

# Function to update PROD_MODE value
update_prod_mode() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        run_command sed -i '' 's/static const bool PROD_MODE = false;/static const bool PROD_MODE = true;/' lib/core/constants/app_secrets.dart
    else
        run_command sed -i 's/static const bool PROD_MODE = false;/static const bool PROD_MODE = true;/' lib/core/constants/app_secrets.dart
    fi
}

# Function to revert PROD_MODE value
revert_prod_mode() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        run_command sed -i '' 's/static const bool PROD_MODE = true;/static const bool PROD_MODE = false;/' lib/core/constants/app_secrets.dart
    else
        run_command sed -i 's/static const bool PROD_MODE = true;/static const bool PROD_MODE = false;/' lib/core/constants/app_secrets.dart
    fi
}

# Function for Android build process
android_build() {
    local build_type=$1
    
    print_section "Starting Android Build Process"
    
    print_status "🧹 Cleaning project..."
    run_command flutter clean

    print_status "🔧 Repairing pub cache..."
    run_command flutter pub cache repair

    print_status "🧹 Cleaning Gradle..."
    cd android
    run_command ./gradlew clean
    cd ..

    print_status "🗑️ Removing build directory..."
    run_command rm -rf build/

    print_status "📦 Getting dependencies..."
    run_command flutter pub get

    print_status "🏗️ Running build runner..."
    run_command dart run build_runner build --delete-conflicting-outputs

    if [ "$build_type" == "apk" ]; then
        print_status "📱 Building APK..."
        run_command flutter build apk --release
        print_section "🤖 APK Build Complete!"
        print_status "APK location: build/app/outputs/flutter-apk/app-release.apk"
    else
        print_status "📱 Building App Bundle (AAB)..."
        run_command flutter build appbundle --release
        print_section "🤖 App Bundle Build Complete!"
        print_status "AAB location: build/app/outputs/bundle/release/app-release.aab"
        
        print_section "Play Store Release Steps"
        print_status "1. Go to Google Play Console (play.google.com/console)"
        print_status "2. Select your app"
        print_status "3. Go to Production → Create new release"
        print_status "4. Upload the AAB file from: build/app/outputs/bundle/release/app-release.aab"
        print_status "5. Add release notes"
        print_status "6. Save and review release"
        print_status "7. Start rollout to Production"
    fi
}

# Function for iOS build process
ios_build() {
    local build_type=$1
    
    print_section "🍎 Starting iOS Build Process"
    
    print_status "🧹 Cleaning iOS dependencies..."
    cd ios
    run_command pod deintegrate
    run_command pod cache clean --all
    run_command rm -rf Pods/
    run_command rm -rf .symlinks/
    run_command rm -rf Podfile.lock
    cd ..

    print_status "🧹 Cleaning Flutter..."
    run_command flutter clean

    print_status "📦 Getting Flutter dependencies..."
    run_command flutter pub get

    print_status "📱 Installing pods..."
    cd ios
    run_command pod install
    cd ..

    print_status "🏗️ Running build runner..."
    run_command dart run build_runner build --delete-conflicting-outputs

    print_status "Checking for XCBBuildService lock..."
    BUILD_SERVICE_PID=$(pgrep XCBBuildService)
    if [ ! -z "$BUILD_SERVICE_PID" ]; then
        print_status "Found XCBBuildService process (PID: $BUILD_SERVICE_PID), killing it..."
        run_command kill -9 $BUILD_SERVICE_PID
        print_status "XCBBuildService process killed successfully"
    fi

    if [ "$build_type" == "xcode" ]; then
        print_section "Xcode Build Steps"
        print_status "1. Open Xcode workspace: ios/Runner.xcworkspace"
        print_status "2. Select 'Any iOS Device' as the build target"
        print_status "3. Go to Product → Archive"
        print_status "4. In Archive window, click 'Distribute App'"
        print_status "5. Select 'App Store Connect' → 'Upload'"
        print_status "6. Follow the signing and upload process"
    else
        print_section "TestFlight Distribution Steps"
        print_status "1. Open Xcode workspace: ios/Runner.xcworkspace"
        print_status "2. Select 'Any iOS Device' as the build target"
        print_status "3. Increment build number in Runner target"
        print_status "4. Go to Product → Archive"
        print_status "5. Select 'Distribute App' → 'TestFlight'"
        print_status "6. Follow TestFlight distribution steps"
    fi
}

# Main script
clear
print_section "Flutter Release Build Script"

# Platform selection
echo "Select platform:"
echo "1: Android"
echo "2: iOS"
read -p "Enter your choice (1/2): " platform_choice

# Update PROD_MODE before building
print_status "Updating PROD_MODE to true..."
update_prod_mode

case $platform_choice in
    1)
        echo ""
        echo "Select Android build type:"
        echo "1: APK (for direct distribution)"
        echo "2: App Bundle (for Play Store)"
        read -p "Enter your choice (1/2): " android_choice
        
        case $android_choice in
            1)
                android_build "apk"
                ;;
            2)
                android_build "aab"
                ;;
            *)
                print_status "Invalid choice. Please select 1 for APK or 2 for App Bundle." "error"
                exit 1
                ;;
        esac
        ;;
    2)
        echo ""
        echo "Select iOS build type:"
        echo "1: Build for App Store"
        echo "2: Build for TestFlight"
        read -p "Enter your choice (1/2): " ios_choice
        
        case $ios_choice in
            1)
                ios_build "xcode"
                ;;
            2)
                ios_build "testflight"
                ;;
            *)
                print_status "Invalid choice. Please select 1 for App Store or 2 for TestFlight." "error"
                exit 1
                ;;
        esac
        ;;
    *)
        print_status "Invalid choice. Please select 1 for Android or 2 for iOS." "error"
        exit 1
        ;;
esac

print_section "Build Process Complete! 🎉"