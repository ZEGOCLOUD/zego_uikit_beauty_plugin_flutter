package com.zegocloud.zego_uikit_beauty_plugin;

import android.graphics.SurfaceTexture;

import java.nio.ByteBuffer;

import im.zego.zego_effects_plugin.ZGEffectsHelper;
import im.zego.zego_express_engine.IZegoFlutterCustomVideoProcessHandler;
import im.zego.zego_express_engine.ZGFlutterPublishChannel;
import im.zego.zego_express_engine.ZGFlutterVideoFrameParam;
import im.zego.zego_express_engine.ZegoCustomVideoProcessManager;
import im.zego.effects.entity.ZegoEffectsVideoFrameParam;
import im.zego.effects.enums.ZegoEffectsVideoFrameFormat;

public class ZegoBeautyPluginVideoProcess implements IZegoFlutterCustomVideoProcessHandler {

    private volatile static ZegoBeautyPluginVideoProcess singleton;

    public ZegoBeautyPluginVideoProcess() {

    }

    public static synchronized ZegoBeautyPluginVideoProcess getInstance() {
        if (singleton == null) {
            singleton = new ZegoBeautyPluginVideoProcess();
        }
        return singleton;
    }

    public void enableCustomVideoProcessing() {
        ZegoCustomVideoProcessManager.getInstance().setCustomVideoProcessHandler(this);
    }

    @Override
    public void onStart(ZGFlutterPublishChannel channel) {

    }

    @Override
    public void onStop(ZGFlutterPublishChannel channel) {

    }

    @Override
    public void onCapturedUnprocessedTextureData(int textureID, int width, int height, long referenceTimeMillisecond,
            ZGFlutterPublishChannel channel) {
        ZegoEffectsVideoFrameParam param = new ZegoEffectsVideoFrameParam();
        param.format = ZegoEffectsVideoFrameFormat.RGBA32;
        param.width = width;
        param.height = height;

        int processedTextureID = ZGEffectsHelper.getInstance().processTexture(textureID, param);
        ZegoCustomVideoProcessManager.getInstance().sendProcessedTextureData(processedTextureID, width, height,
                referenceTimeMillisecond, channel);
    }

    @Override
    public SurfaceTexture getCustomVideoProcessInputSurfaceTexture(int width, int height,
            ZGFlutterPublishChannel channel) {
        return null;
    }

    @Override
    public void onCapturedUnprocessedRawData(ByteBuffer data, int[] dataLength,
                                             ZGFlutterVideoFrameParam param,
                                             long referenceTimeMillisecond,
                                             ZGFlutterPublishChannel channel){
    }
}
