package com.neudesic.azureservicebustest.data;

import android.content.Context;
import com.neudesic.azureservicebustest.asynchttp.AsyncHttpResponseHandler;
import com.neudesic.azureservicebustest.asynchttp.RequestParams;
import com.neudesic.azureservicebustest.utils.AzurePropertiesReader;

import java.util.Properties;

/**
 * Created by vincent.guerin on 12/6/13.
 */
public class AzureUser {
    private static AzureUser instance = null;
    private static Properties properties;
    private final Context context;
    private String azureToken;
    public static final String API_AUTHENTICATE_ENDPOINT = "WRAPv0.9";

    public AzureUser(Context context) {
        this.context = context;
    }

    public static AzureUser currentUser(Context context) {
        if(instance == null) {
            instance = new AzureUser(context);
            properties = new AzurePropertiesReader(context).getProperties();
        }
        return instance;
    }

    public void authenticateUser(AsyncHttpResponseHandler asyncHttpResponseHandler) {
        RequestParams params = new RequestParams();
        params.put("wrap_scope", "http://" + properties.getProperty("ServiceBusName") + ".servicebus.windows.net/");
        params.put("wrap_name", properties.getProperty("AzureUsername"));
        params.put("wrap_password", properties.getProperty("AzurePassword"));

        AzureClient.getInstance(context).post(context, API_AUTHENTICATE_ENDPOINT, params, asyncHttpResponseHandler);
    }

    public String getToken() {
        return azureToken;
    }

    public void setToken(String azureToken) {
        this.azureToken = azureToken;
    }
}
