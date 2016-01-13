//
//  VC_Thermostat.h
//  ATT_Hack_2015
//
//  Created by Aaron Crawfis on 10/2/15.
//  Copyright © 2015 Aaron Crawfis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VC_Thermostat : UIViewController

@property int currentTemperature;
@property int desiredTemperature;
@property int currentMode;

@property (strong, nonatomic) IBOutlet UILabel *currentTempLabel;
@property (strong, nonatomic) IBOutlet UILabel *desiredTempLabel;
@property (strong, nonatomic) IBOutlet UIStepper *desiredTempStepper;

@property (strong, nonatomic) IBOutlet UISegmentedControl *thermostatMode;

- (IBAction)desiredTempStepperChanged:(UIStepper *)sender;
- (IBAction)thermostatModeChanged:(UISegmentedControl *)sender;

@property (strong, nonatomic) NSArray *thermostatDevices;

@end
