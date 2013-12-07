package com.neudesic.azureservicebustest;

import android.content.Context;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;
import roboguice.activity.RoboActivity;
import roboguice.inject.InjectView;

/**
 * Created by vincent.guerin on 12/6/13.
 */
public class SendMessageActivity extends RoboActivity {
    @InjectView(R.id.message_input_edittext)
    EditText messageInputEditText;

    @InjectView(R.id.send_message_button)
    Button sendMessageButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.send_message);

        setupButtonOnClickListeners();
        showKeyboard();
    }

    private void showKeyboard() {
        InputMethodManager imm = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
        imm.showSoftInput(messageInputEditText, 0);
    }

    private void setupButtonOnClickListeners() {
        sendMessageButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (messageInputEditText.getText().length() > 0) {
                    // TODO: Implement
                } else {
                    Toast.makeText(SendMessageActivity.this, getString(R.string.no_text_inputted_error), Toast.LENGTH_SHORT).show();
                }
            }
        });
    }
}
