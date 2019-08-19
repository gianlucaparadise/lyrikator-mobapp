package com.example.lyrikator;

import android.app.SearchManager;
import android.content.Intent;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    private String savedSearchQuery;
    private static final String ACTION_VOICE_SEARCH = "com.google.android.gms.actions.SEARCH_ACTION";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
      Intent intent = getIntent();
      String action = intent.getAction();

      if (ACTION_VOICE_SEARCH.equals(action)) {
          savedSearchQuery = intent.getStringExtra(SearchManager.QUERY);
      }

      new MethodChannel(getFlutterView(), "app.channel.shared.data")
              .setMethodCallHandler((methodCall, result) -> {
                  if (methodCall.method.contentEquals("getSavedSearchQuery")) {
                      result.success(savedSearchQuery);
                      savedSearchQuery = null;
                  }
              });
  }
}
