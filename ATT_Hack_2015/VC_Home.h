//
//  VC_Home.h
//  ATT_Hack_2015
//
//  Created by Aaron Crawfis on 10/2/15.
//  Copyright © 2015 Aaron Crawfis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VC_Home : UIViewController

@property BOOL firstRun;
@property BOOL isLoggedIn;

@property(strong, nonatomic) NSString *firstName;

@property (strong, nonatomic) IBOutlet UILabel *titleText;
@property (strong, nonatomic) IBOutlet UILabel *subTitleText;

- (IBAction)signOutButtonPressed:(UIButton *)sender;
- (IBAction)signInButtonPressed:(UIButton *)sender;

@end
