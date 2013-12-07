package com.neudesic.azureservicebustest.utils;

import android.content.Context;
import android.content.res.AssetManager;
import android.util.Log;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * Created by vincent.guerin on 12/6/13.
 */
public class AzurePropertiesReader {
    private final String TAG = "AzurePropertiesReader";
    private Context context;
    private Properties properties;
    private static final String propertiesFileName = "AzureLoginInfo.properties";

    public AzurePropertiesReader(Context context) {
        this.context = context;
        properties = new Properties();
    }

    public Properties getProperties() {
        try {
            AssetManager assetManager = context.getAssets();
            InputStream inputStream = assetManager.open(propertiesFileName);
            properties.load(inputStream);
        } catch (IOException e) {
            Log.e(TAG, e.getMessage());
        }
        return properties;
    }

}
