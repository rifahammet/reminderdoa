package com.onethinklogic.doamuslim;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

public class BootBroadcastReceiver extends BroadcastReceiver {
     private static final String TAG = BootBroadcastReceiver.class.getSimpleName();
     @Override
     public void onReceive(Context context, Intent intent) {
         Log.i(TAG, "BOOT detected");
         if (Intent.ACTION_BOOT_COMPLETED.equals(intent.getAction())) {
             Intent serviceIntent = new Intent(context, MainActivity.class);
             context.startService(serviceIntent);
         }
     }
}