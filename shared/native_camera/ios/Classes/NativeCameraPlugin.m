#import "NativeCameraPlugin.h"
#if __has_include(<native_camera/native_camera-Swift.h>)
#import <native_camera/native_camera-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "native_camera-Swift.h"
#endif

@implementation NativeCameraPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNativeCameraPlugin registerWithRegistrar:registrar];
}
@end
