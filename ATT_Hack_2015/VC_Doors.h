//
//  VC_Doors.h
//  ATT_Hack_2015
//
//  Created by Aaron Crawfis on 10/2/15.
//  Copyright © 2015 Aaron Crawfis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VC_Doors : UIViewController

@property BOOL frontDoorLocked;
@property BOOL backDoorLocked;

@property BOOL frontDoorOpen;
@property BOOL garageDoorOpen;
@property BOOL backDoorOpen;

@property BOOL kitchenWindowOpen;
@property BOOL masterBedroomWindowOpen;
@property BOOL bedroomAWindowOpen;

@property (strong, nonatomic) IBOutlet UISwitch *frontDoorSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *backDoorSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *garageDoorSwitch;


- (IBAction)frontDoorSwitch:(UISwitch *)sender;
- (IBAction)backDoorSwitch:(UISwitch *)sender;
- (IBAction)garageDoorSwitch:(UISwitch *)sender;

@property (strong, nonatomic) IBOutlet UILabel *frontDoorLabel;
@property (strong, nonatomic) IBOutlet UILabel *garageDoorLabel;
@property (strong, nonatomic) IBOutlet UILabel *backDoorLabel;
@property (strong, nonatomic) IBOutlet UILabel *kitchenWindowLabel;
@property (strong, nonatomic) IBOutlet UILabel *masterWindowLabel;
@property (strong, nonatomic) IBOutlet UILabel *bedroomAWindowLabel;

@property (strong, nonatomic) NSArray *sensorDevices;
@property (strong, nonatomic) NSArray *doorLockDevices;
@property (strong, nonatomic) NSArray *garageDevices;

@property NSString *lockState;
@property NSString *garageState;

@end
