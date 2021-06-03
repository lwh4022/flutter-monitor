package com.infotech.flutter_monitor;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    private static final String CHANNEL = "ift-engine-call";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine){
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        final MethodChannel channel = new MethodChannel(flutterEngine.getDartExecutor(), CHANNEL);
        channel.setMethodCallHandler(handler);
    }

    private MethodChannel.MethodCallHandler handler = (methodCall, result) -> {
        if(methodCall.method.equals("startEngine")){

            String inJson = String.valueOf(methodCall.arguments);
            String outJson = startEngine(inJson);
            result.success(outJson);
        } else {
            result.notImplemented();
        }
    };

    private String startEngine(String inJson){
        return "inJson : " + inJson + ", outJson이 출력됩니다";
    }


}
