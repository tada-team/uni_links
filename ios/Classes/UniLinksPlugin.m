#import "UniLinksPlugin.h"
#if __has_include(<uni_links/uni_links-Swift.h>)
#import <uni_links/uni_links-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "uni_links-Swift.h"
#endif

@implementation UniLinksPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftUniLinksPlugin registerWithRegistrar:registrar];
}
@end
