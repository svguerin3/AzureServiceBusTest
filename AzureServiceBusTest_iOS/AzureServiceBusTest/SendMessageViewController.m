//
//  SendMessageViewController.m
//  AzureServiceBusTest
//
//  Created by Vincent Guerin on 12/5/13.
//  Copyright (c) 2013 Neudesic. All rights reserved.
//

#import "SendMessageViewController.h"
#import "AzureMessenger.h"

@interface SendMessageViewController ()
@property (nonatomic, weak) IBOutlet UITextView *inputTextView;
@end

@implementation SendMessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.inputTextView becomeFirstResponder];
}

#pragma mark - IBActions

- (IBAction)sendButtonPressed:(id)sender {
    if ([self.inputTextView.text length] > 0) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [AzureMessenger sendMessageToQueue:self.inputTextView.text success:^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [UIAlertView alertViewWithTitle:@"Success!" message:@"Message successfully sent to the queue"];
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [UIAlertView alertViewWithTitle:@"Error" message:error.localizedDescription];
        }];
    } else {
        [UIAlertView alertViewWithTitle:@"Alert" message:@"Please enter a message to send to the queue"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
