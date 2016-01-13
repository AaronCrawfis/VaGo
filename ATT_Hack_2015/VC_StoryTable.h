//
//  VC_StoryTable.h
//  ATT_Hack_2015
//
//  Created by Aaron Crawfis on 10/3/15.
//  Copyright © 2015 Aaron Crawfis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "storyObject.h"

@interface VC_StoryTable : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *storyTable;
- (IBAction)backButtonPressed:(UIButton *)sender;

@property (strong, nonatomic) NSMutableArray *storyList;

@property (strong, nonatomic) storyObject *story;

@end
