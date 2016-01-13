//
//  VC_Story.h
//  ATT_Hack_2015
//
//  Created by Aaron Crawfis on 10/3/15.
//  Copyright © 2015 Aaron Crawfis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "storyObject.h"

@interface VC_Story : UIViewController

@property (strong, nonatomic) storyObject *story;

@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextView *body;

- (IBAction)backButtonPressed:(UIButton *)sender;

@end
