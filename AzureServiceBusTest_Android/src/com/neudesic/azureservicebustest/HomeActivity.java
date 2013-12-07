package com.neudesic.azureservicebustest;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;
import com.neudesic.azureservicebustest.asynchttp.AsyncHttpResponseHandler;
import com.neudesic.azureservicebustest.data.AzureClient;
import com.neudesic.azureservicebustest.data.AzureUser;
import org.apache.http.Header;
import roboguice.activity.RoboActivity;
import roboguice.inject.InjectView;

public class HomeActivity extends RoboActivity {
    private final static String TAG = "HomeActivity";

    @InjectView(R.id.login_button)
    Button loginButton;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        setupButtonOnClickListeners();
    }

    private void setupButtonOnClickListeners() {
        loginButton.setOnClickListener(new View.OnClickListener() {
            private ProgressDialog progressDialog;

            @Override
            public void onClick(View view) {
                final AzureUser currentUser = AzureUser.currentUser(HomeActivity.this);

                currentUser.authenticateUser(new AsyncHttpResponseHandler() {
                    @Override
                    public void onStart() {
                        super.onStart();

                        progressDialog = new ProgressDialog(HomeActivity.this);
                        progressDialog.setMessage(getString(R.string.logging_in));
                        progressDialog.show();
                    }

                    @Override
                    public void onSuccess(String content) {
                        super.onSuccess(content);

                        currentUser.setTokenFromAuthString(content);

                        Intent intent = new Intent(HomeActivity.this, SendMessageActivity.class);
                        startActivity(intent);
                    }

                    @Override
                    public void onFailure(Throwable error, String content) {
                        super.onFailure(error, content);
                        Toast.makeText(HomeActivity.this, "Error: " + error.getLocalizedMessage(), Toast.LENGTH_SHORT).show();
                    }

                    @Override
                    public void onFinish() {
                        super.onFinish();
                        progressDialog.hide();
                    }
                });
            }
        });
    }
}
