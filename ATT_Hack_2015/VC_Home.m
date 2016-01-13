//
//  VC_Home.m
//  ATT_Hack_2015
//
//  Created by Aaron Crawfis on 10/2/15.
//  Copyright © 2015 Aaron Crawfis. All rights reserved.
//

#import "VC_Home.h"
#import "VC_Login.h"
#import "DLClient.h"
#import "Constants.h"
#import "DLeServiceConnection.h"

@interface VC_Home ()

@end

@implementation VC_Home

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.foodButton.hidden = YES;
    self.contactButton.hidden = YES;
    self.signoutButton.hidden = YES;
    self.storyButton.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)signOutButtonPressed:(UIButton *)sender
{
    self.foodButton.hidden = YES;
    self.contactButton.hidden = YES;
    self.signoutButton.hidden = YES;
    self.storyButton.hidden = YES;
    self.logoImage.hidden = NO;
    
    self.signInButton.hidden = NO;
    self.subTitleText.text = @"Please Sign In:";
}

- (IBAction)signInButtonPressed:(UIButton *)sender
{
    //Set self to listen for the message "VC_LoginDismissed" and run a method when this message is detected
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didDismissVC_Login)
                                                 name:@"VC_LoginDismissed"
                                               object:nil];
    [self performSegueWithIdentifier:@"loginSegue" sender:self];
}

- (IBAction)foodButtonPressed:(UIButton *)sender {
}

- (IBAction)contactButonPressed:(UIButton *)sender {
}

- (IBAction)journalButtonPressed:(UIButton *)sender {
}

-(void)didDismissVC_Login
{
    self.subTitleText.text = @"Hello Aaron";
    self.signInButton.hidden = YES;
    self.logoImage.hidden = YES;
    
    self.foodButton.hidden = NO;
    self.contactButton.hidden = NO;
    self.signoutButton.hidden = NO;
    self.storyButton.hidden = NO;
}
@end
