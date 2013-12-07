package com.neudesic.azureservicebustest;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import roboguice.activity.RoboActivity;
import roboguice.inject.InjectView;

public class HomeActivity extends RoboActivity {
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
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(HomeActivity.this, SendMessageActivity.class);
                startActivity(intent);
            }
        });
    }
}
