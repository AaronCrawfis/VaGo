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
@property (strong, nonatomic) IBOutlet UIButton *foodButton;
@property (strong, nonatomic) IBOutlet UIButton *storyButton;
@property (strong, nonatomic) IBOutlet UIButton *contactButton;
@property (strong, nonatomic) IBOutlet UIButton *signoutButton;
@property (strong, nonatomic) IBOutlet UIImageView *logoImage;

- (IBAction)signOutButtonPressed:(UIButton *)sender;
- (IBAction)signInButtonPressed:(UIButton *)sender;
- (IBAction)foodButtonPressed:(UIButton *)sender;
- (IBAction)journalButtonPressed:(UIButton *)sender;
- (IBAction)contactButonPressed:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIButton *signInButton;

@end
