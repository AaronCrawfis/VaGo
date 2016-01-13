//
//  VC_LightsViewController.m
//  ATT_Hack_2015
//
//  Created by Aaron Crawfis on 10/2/15.
//  Copyright © 2015 Aaron Crawfis. All rights reserved.
//

#import "VC_Lights.h"
#import "DLClient.h"
#import "Constants.h"
#import "DLeServiceConnection.h"
#import "DLDevice.h"

@interface VC_Lights ()

@end

@implementation VC_Lights

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Log In
    NSLog(@"Logging In");
    DLClient *client = [DLClient shared];
    [client authenticateWithUsername:kSampleUsername password:kSamplePassword completion:^(BOOL success){
        if (success)
        {
            NSLog(@"Logged In");
            [self startEService];
        }
        else NSLog(@"Failure to Login");
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Light Switches

- (IBAction)kitchenLightsSwitch:(UISwitch *)sender
{
    if(self.kitchenLightsOn)
    {
        self.kitchenLightsOn = false;
        self.lightState = @"off";
    }
    else
    {
        self.kitchenLightsOn = true;
        self.lightState = @"on";
        
    } // End of Else
    
    for (DLDevice *lightcontrol in self.lightswitchDevices)
    {
        [[DLClient shared] updateDeviceWithDeviceID:lightcontrol.deviceGuid forAction:@"switch" withValue:self.lightState completionHandler:^ (BOOL success, NSNumber *transactionID) {
            // if there was no transaction id then the switch was already set to the value we requested, otherwise we mark the device as having a pending change on the "switch" label
            if (transactionID && (transactionID.integerValue != -1))
            {
                NSLog(@"Light Switched");
            }
            else
            {
                NSLog(@"Nothing Happened");
            }
    }]; // End of [DLClient]
    }
}

- (IBAction)drivewayLightsSwitch:(UISwitch *)sender
{
    
}

- (IBAction)deckLightsSwitch:(UISwitch *)sender
{
    if(self.deckLightsOn)
    {
        self.deckLightsOn = false;
        self.lightState = @"off";
    }
    else
    {
        self.deckLightsOn = true;
        self.lightState = @"on";
        
    } // End of Else
    
    for (DLDevice *lightcontrol in self.nightLightDevices)
    {
        [[DLClient shared] updateDeviceWithDeviceID:lightcontrol.deviceGuid forAction:@"switch" withValue:self.lightState completionHandler:^ (BOOL success, NSNumber *transactionID) {
            // if there was no transaction id then the switch was already set to the value we requested, otherwise we mark the device as having a pending change on the "switch" label
            if (transactionID && (transactionID.integerValue != -1))
            {
                NSLog(@"Light Switched");
            }
            else
            {
                NSLog(@"Nothing Happened");
            }
        }]; // End of [DLClient]
    }

}

#pragma mark - AT&T Functions

- (void)startEService
{
    [[DLClient shared] startEServiceWithCompletion:^(BOOL success) {
        if (success)
        {
            NSLog(@"eService Started");
            [self loadDevices];
        }
    }];
}

- (void)loadDevices
{
    [[DLClient shared] loadDevicesWithCompletion:^(BOOL success, NSArray *devices) {
        if (success)
        {
            NSLog(@"Devices Loaded");
            [self searchDevices];
        }
    }];
}

- (void) searchDevices
{
    // Find All Light Switch Devices
    NSLog(@"Searching for Devices");
    
    // Big Light Bulb
    NSMutableArray *lightSwitchDevices = [[NSMutableArray alloc] init];
    NSArray *allDevices = [[DLClient shared] devices];
    for (DLDevice *device in allDevices)
    {
        if (([device.deviceType isEqualToString:@"light-control"] && device.attributes[@"switch"] != nil))
        {
            NSLog(@"Device Found");
            [lightSwitchDevices addObject:device];
            NSString *isLightOn = [device.attributes[@"status"] objectForKey:@"value"];
            if([isLightOn isEqual:@"0"])
            {
                NSLog(@"The Light Switch is Turned Off");
                [self.kitchenLightsSwitch setOn:NO];
            }
        }
    }
    // Save a Copy
    self.lightswitchDevices = [lightSwitchDevices copy];
    
    // Night Light
    NSMutableArray *nightLightDevices = [[NSMutableArray alloc] init];
    for (DLDevice *device in allDevices)
    {
        if (([device.deviceType isEqualToString:@"smart-plug"] && device.attributes[@"switch"] != nil))
        {
            NSLog(@"Device Found");
            [nightLightDevices addObject:device];
            NSString *isLightOn = [device.attributes[@"status"] objectForKey:@"value"];
            if([isLightOn isEqual:@"0"])
            {
                NSLog(@"The Light Switch is Turned Off");
                [self.deckLightsSwitch setOn:NO];
            }
        }
    }
    // Save a Copy
    self.nightLightDevices = [nightLightDevices copy];
    
    // Update Switches
    //[self updateSwitches];
}

#pragma mark - My Functions

- (void) updateSwitches
{
    // Get Light Infotmation
    self.kitchenLightsOn = false;
    self.drivewayLightsOn = true;
    self.deckLightsOn = true;
    
    // Match Switch Values
    if (!self.kitchenLightsOn) [self.kitchenLightsSwitch setOn:NO];
    if (!self.deckLightsOn) [self.deckLightsSwitch setOn:NO];
}

@end
