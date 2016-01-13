//
//  VC_ContactInfo.h
//  ATT_Hack_2015
//
//  Created by Aaron Crawfis on 10/3/15.
//  Copyright © 2015 Aaron Crawfis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "MessageComposerViewController.h"

@interface VC_ContactInfo : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *commentField;

- (IBAction)cancelButtonPressed:(UIButton *)sender;
- (IBAction)sendButtonPressed:(UIButton *)sender;

@property NSString *phone;
@property NSString *comment;

@end
