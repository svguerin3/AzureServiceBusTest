package com.neudesic.azureservicebustest;

import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;
import com.neudesic.azureservicebustest.asynchttp.AsyncHttpResponseHandler;
import com.neudesic.azureservicebustest.data.AzureMessenger;
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
                    AzureMessenger.sendMessageToQueue(SendMessageActivity.this, messageInputEditText.getText().toString(), new AsyncHttpResponseHandler() {
                        public ProgressDialog progressDialog;

                        @Override
                        public void onStart() {
                            super.onStart();

                            progressDialog = new ProgressDialog(SendMessageActivity.this);
                            progressDialog.setMessage(getString(R.string.sending_message));
                            progressDialog.show();
                        }

                        @Override
                        public void onSuccess(String content) {
                            super.onSuccess(content);

                            Toast.makeText(SendMessageActivity.this, getString(R.string.success_message_to_queue), Toast.LENGTH_SHORT).show();
                        }

                        @Override
                        public void onFailure(Throwable error, String content) {
                            super.onFailure(error, content);

                            Log.d("SVG", "content: " + content);
                            Toast.makeText(SendMessageActivity.this, "Error: " + error.getLocalizedMessage(), Toast.LENGTH_SHORT).show();
                        }

                        @Override
                        public void onFinish() {
                            super.onFinish();
                            progressDialog.hide();
                        }
                    });
                } else {
                    Toast.makeText(SendMessageActivity.this, getString(R.string.no_text_inputted_error), Toast.LENGTH_SHORT).show();
                }
            }
        });
    }
}
