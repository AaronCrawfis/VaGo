//
//  VC_Login.m
//  ATT_Hack_2015
//
//  Created by Aaron Crawfis on 10/2/15.
//  Copyright © 2015 Aaron Crawfis. All rights reserved.
//

#import "VC_Login.h"
#import "DLClient.h"
#import "Constants.h"
#import "DLeServiceConnection.h"

@interface VC_Login ()

@end

@implementation VC_Login

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginButtonPressed:(UIButton *)sender
{
    //This sends a message through the NSNotificationCenter to any listeners for "SecondViewControllerDismissed"
    [[NSNotificationCenter defaultCenter] postNotificationName:@"VC_LoginDismissed"
                                                        object:nil
                                                      userInfo:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
