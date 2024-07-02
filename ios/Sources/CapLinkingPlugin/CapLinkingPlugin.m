#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

CAP_PLUGIN(CapLinkingPlugin, "CapLinking",

           CAP_PLUGIN_METHOD(openURL, CAPPluginReturnPromise);
        CAP_PLUGIN_METHOD(canOpenURL, CAPPluginReturnPromise);
             
)
