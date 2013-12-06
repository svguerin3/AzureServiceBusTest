//
//  LoginViewController.m
//  AzureServiceBusTest
//
//  Created by Vincent Guerin on 12/5/13.
//  Copyright (c) 2013 Neudesic. All rights reserved.
//

#import "LoginViewController.h"
#import "AzureUser.h"

@interface LoginViewController ()
@property (nonatomic, strong) IBOutlet UILabel *userNameLabel;
@end

@implementation LoginViewController

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
    
    self.userNameLabel.text = [AzureUtils fetchFromPlistWithKey:kPlistKeyUserName];
}

#pragma mark - IBActions

- (IBAction)loginButtonPressed:(id)sender {
    [AzureUser authenticateAzureUserWithSuccess:^{
        NSLog(@"success!");
    } failure:^(NSError *error) {
        [UIAlertView alertViewWithTitle:@"Error" message:error.localizedDescription];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
