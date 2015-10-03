//
//  VC_LightsViewController.h
//  ATT_Hack_2015
//
//  Created by Aaron Crawfis on 10/2/15.
//  Copyright © 2015 Aaron Crawfis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VC_Lights : UIViewController

@property NSString *lightState;

@property BOOL kitchenLightsOn;
@property BOOL drivewayLightsOn;
@property BOOL deckLightsOn;

- (IBAction)kitchenLightsSwitch:(UISwitch *)sender;
- (IBAction)drivewayLightsSwitch:(UISwitch *)sender;
- (IBAction)deckLightsSwitch:(UISwitch *)sender;

@property (strong, nonatomic) IBOutlet UISwitch *kitchenLightsSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *drivewayLightsSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *deckLightsSwitch;

@property (nonatomic,strong) NSArray *lightswitchDevices;
@property (nonatomic,strong) NSArray *nightLightDevices;

@end
