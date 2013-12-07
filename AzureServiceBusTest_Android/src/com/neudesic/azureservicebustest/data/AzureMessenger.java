package com.neudesic.azureservicebustest.data;

import android.content.Context;
import android.util.Log;
import com.neudesic.azureservicebustest.asynchttp.AsyncHttpResponseHandler;

import java.io.UnsupportedEncodingException;
import java.net.*;

/**
 * Created by vincent.guerin on 12/6/13.
 */
public class AzureMessenger {
    public static final String API_MESSAGES_ENDPOINT = "messages";
    private static final String TAG = "AzureMessenger";

    public static void sendMessageToQueue(Context context, String message, AsyncHttpResponseHandler asyncHttpResponseHandler) {
        // TODO: set message to request body

        try {
            AzureClient.getInstance(context).post(context,
                    API_MESSAGES_ENDPOINT,
                    null,
                    URLDecoder.decode(AzureUser.currentUser(context).getToken(), "UTF-8"),
                    asyncHttpResponseHandler);
        } catch (UnsupportedEncodingException e) {
            Log.e(TAG, e.getMessage());
            throw new RuntimeException("Token decoding error");
        }
    }
}
