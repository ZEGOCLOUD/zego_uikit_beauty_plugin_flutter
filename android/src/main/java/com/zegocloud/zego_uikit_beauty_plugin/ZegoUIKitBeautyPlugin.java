package com.zegocloud.zego_uikit_beauty_plugin;

import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;

import java.io.File;
import java.io.IOException;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** ZegoUIKitBeautyPlugin */
public class ZegoUIKitBeautyPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native
  /// Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine
  /// and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  private Context mContext;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "zego_uikit_beauty_plugin");
    channel.setMethodCallHandler(this);

    mContext = flutterPluginBinding.getApplicationContext();
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    }

    else if (call.method.equals("enableCustomVideoProcessing")) {
      ZegoBeautyPluginVideoProcess.getInstance().enableCustomVideoProcessing();
      result.success(null);
    }

    else if (call.method.equals("getResourcesFolder")) {

      String path = mContext.getExternalCacheDir().getPath() + File.separator + "BeautyResources";
      result.success(path);

      // copy all files from assets.
      ZegoFileUtil.copyFileFromAssets(mContext, "BeautyResources", path);

      Log.i("TAG", "onMethodCall: " + path);
    }

    else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
