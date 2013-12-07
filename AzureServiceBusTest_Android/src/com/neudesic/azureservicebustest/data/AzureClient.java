package com.neudesic.azureservicebustest.data;

import android.content.Context;
import android.util.Log;
import com.neudesic.azureservicebustest.asynchttp.AsyncHttpClient;
import com.neudesic.azureservicebustest.asynchttp.AsyncHttpResponseHandler;
import com.neudesic.azureservicebustest.asynchttp.RequestParams;
import com.neudesic.azureservicebustest.utils.AzurePropertiesReader;
import org.apache.http.HttpEntity;

import java.util.Properties;

/**
 * Created by vincent.guerin on 12/6/13.
 */
public class AzureClient {
    private static Properties properties;
    private final Context context;
    private static AsyncHttpClient client;
    private static AzureClient instance = null;

    public AzureClient(Context context) {
        this.context = context;
    }

    public static AzureClient getInstance(Context context) {
        if(instance == null) {
            instance = new AzureClient(context);
            client = new AsyncHttpClient();
            properties = new AzurePropertiesReader(context).getProperties();
        }
        return instance;
    }

    public void get(String endPoint, RequestParams params, AsyncHttpResponseHandler responseHandler) {
        client.get(getAbsoluteUrl(endPoint), params, responseHandler);
    }

    public void post(Context context, String url, RequestParams params, AsyncHttpResponseHandler responseHandler) {
        client.post(context, getAbsoluteUrl(url), params, responseHandler);
    }

    private String getAbsoluteUrl(String endPoint) {
        String url;
        if (AzureUser.currentUser(context).getToken() != null) {
            url = "https://" +
                    properties.getProperty("ServiceBusName") +
                    ".servicebus.Windows.net/" +
                    properties.getProperty("ServiceQueueName");
        } else {
            url = "https://" + properties.getProperty("ServiceBusName") + "-sb.accesscontrol.windows.net";
        }

        return url + "/" + endPoint;
    }
}
