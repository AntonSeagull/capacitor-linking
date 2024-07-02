package com.antonseagull.capacitor.linking;

import android.content.Intent;
import android.net.Uri;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.annotation.CapacitorPlugin;
import com.getcapacitor.PluginMethod;

@CapacitorPlugin(name = "CapLinking")
public class CapLinkingPlugin extends Plugin {

    @PluginMethod
    public void openURL(PluginCall call) {
        String urlString = call.getString("url");
        if (urlString == null) {
            call.reject("Invalid URL");
            return;
        }
        Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(urlString));
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        getContext().startActivity(intent);
        call.resolve();
    }

    @PluginMethod
    public void canOpenURL(PluginCall call) {
        String urlString = call.getString("url");
        if (urlString == null) {
            call.reject("Invalid URL");
            return;
        }
        Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(urlString));
        boolean canOpen = intent.resolveActivity(getContext().getPackageManager()) != null;
        JSObject ret = new JSObject();
        ret.put("canOpen", canOpen);
        call.resolve(ret);
    }
}