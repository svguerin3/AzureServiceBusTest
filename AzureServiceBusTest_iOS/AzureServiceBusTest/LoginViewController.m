//
//  LoginViewController.m
//  AzureServiceBusTest
//
//  Created by Vincent Guerin on 12/5/13.
//  Copyright (c) 2013 Neudesic. All rights reserved.
//

#import "LoginViewController.h"
#import "AzureUser.h"

#define kLoggedInSegue @"loggedInSegue"

@interface LoginViewController ()
@property (nonatomic, weak) IBOutlet UILabel *userNameLabel;
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
    
    self.userNameLabel.text = [NSString stringWithFormat:@"Username: %@", [AzureUtils fetchFromPlistWithKey:kPlistKeyUserName]];
}

- (void)viewWillAppear:(BOOL)animated {
    [AzureUser logoutUser];
}

#pragma mark - IBActions

- (IBAction)loginButtonPressed:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [AzureUser authenticateAzureUserWithSuccess:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [self performSegueWithIdentifier:kLoggedInSegue sender:self];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [UIAlertView alertViewWithTitle:@"Error" message:error.localizedDescription];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
