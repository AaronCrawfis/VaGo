//
//  VC_Thermostat.m
//  ATT_Hack_2015
//
//  Created by Aaron Crawfis on 10/2/15.
//  Copyright © 2015 Aaron Crawfis. All rights reserved.
//

#import "VC_Thermostat.h"
#import "DLClient.h"
#import "Constants.h"
#import "DLeServiceConnection.h"
#import "DLDevice.h"

@interface VC_Thermostat ()

@end

@implementation VC_Thermostat

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Log In
    NSLog(@"Logging In");
    DLClient *client = [DLClient shared];
    [client authenticateWithUsername:kSampleUsername password:kSamplePassword completion:^(BOOL success){
        if (success)
        {
            //NSLog(@"Logged In");
            [self startEService];
        }
        else
        {
            //NSLog(@"Failure to Login");
        }
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self
                                   selector:@selector(loadDevices) userInfo:nil repeats:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)desiredTempStepperChanged:(UIStepper *)sender
{
    NSString *setpoint;
    if ([self.thermostatMode selectedSegmentIndex] == 1)
    {
        // Cool Mode
        setpoint = @"cool-setpoint";
    }
    else if ([self.thermostatMode selectedSegmentIndex] == 0)
    {
        // Heat Mode
        setpoint = @"heat-setpoint";
    }
    
    NSLog(@"%f",self.desiredTempStepper.value);
    int sendTemp = ((self.desiredTempStepper.value - 32)/1.8);
    sendTemp = ((sendTemp*2)+80);
    NSString *desiredTemp = [NSString stringWithFormat:@"%d", sendTemp];
    // HTTP Post
    for (DLDevice *thermostats in self.thermostatDevices)
    {
        NSLog(@"!!!!!!!!!!!!!!!!!!!");
        NSLog(@"%@, %@",desiredTemp, setpoint);
        [[DLClient shared] updateDeviceWithDeviceID:thermostats.deviceGuid forAction:setpoint withValue:desiredTemp completionHandler:^ (BOOL success, NSNumber *transactionID) {
            // if there was no transaction id then the switch was already set to the value we requested, otherwise we mark the device as having a pending change on the "switch" label
            if (transactionID && (transactionID.integerValue != -1))
            {
                NSLog(@"Temperature Changed");
                self.desiredTemperature = self.desiredTempStepper.value;
                [self loadDevices];
            }
            else
            {
                NSLog(@"Nothing Happened");
            }
        }]; // End of [DLClient]
    }
}

- (IBAction)thermostatModeChanged:(UISegmentedControl *)sender
{
    // Setup
    NSString *setMode;
    if ([self.thermostatMode selectedSegmentIndex] == 0)
    {
        self.currentMode = 0;
        setMode = @"heat";
        
    }
    else if ([self.thermostatMode selectedSegmentIndex] == 1)
    {
        self.currentMode = 1;
        setMode = @"cool";
    }
    
    // HTTP Post
    for (DLDevice *thermostats in self.thermostatDevices)
    {
        [[DLClient shared] updateDeviceWithDeviceID:thermostats.deviceGuid forAction:@"thermostat-mode" withValue:setMode completionHandler:^ (BOOL success, NSNumber *transactionID) {
            // if there was no transaction id then the switch was already set to the value we requested, otherwise we mark the device as having a pending change on the "switch" label
            if (transactionID && (transactionID.integerValue != -1))
            {
                NSLog(@"Mode Changed");
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
    [[DLClient shared] startEServiceWithCompletion:^(BOOL success)
    {
        if (success)
        {
            //NSLog(@"eService Started");
            [self loadDevices];
        }
    }];
}

- (void)loadDevices
{
    [[DLClient shared] loadDevicesWithCompletion:^(BOOL success, NSArray *devices)
    {
        if (success)
        {
            //NSLog(@"Devices Loaded");
            [self searchDevices];
        }
    }];
}

- (void) searchDevices
{
    // Find All Light Switch Devices
    //NSLog(@"Searching for Devices");
    
    // Thermostats
    NSMutableArray *thermostatDevices = [[NSMutableArray alloc] init];
    NSArray *allDevices = [[DLClient shared] devices];
    for (DLDevice *device in allDevices)
    {
        if ([device.deviceType isEqualToString:@"thermostat"])
        {
            //NSLog(@"Thermostat Found");
            [thermostatDevices addObject:device];
            
            // Get and Set Current Temperature
            NSString *currentTemp = [device.attributes[@"temperature"] objectForKey:@"value"];
            self.currentTemperature = ([currentTemp intValue]/2 -40);
            self.currentTemperature = ((self.currentTemperature * 1.8)+32);
            self.currentTempLabel.text = [NSString stringWithFormat:@"%d", self.currentTemperature];
            
            // Get and Set Mode
            NSString *thermostatMode = [device.attributes[@"thermostat-mode"] objectForKey:@"value"];
            if ([thermostatMode isEqual:@"cool"] || [thermostatMode isEqual:@"save-cool"])
            {
                self.currentMode = 1;
                [self.thermostatMode setSelectedSegmentIndex:1];
            }
            else if ([thermostatMode isEqual:@"heat"] || [thermostatMode isEqual:@"save-heat"])
            {
                self.currentMode = 0;
                [self.thermostatMode setSelectedSegmentIndex:0];
            }
            else
            {
                self.currentMode = -1;
                [self.thermostatMode setSelectedSegmentIndex:UISegmentedControlNoSegment];
            }
            
            // Get and Set Desired Temperature
            if (self.currentMode == 1)
            {
                NSString *desiredTemp = [device.attributes[@"cool-setpoint"] objectForKey:@"value"];
                self.desiredTemperature = ([desiredTemp intValue]/2 -40);
                self.desiredTemperature = ((self.desiredTemperature * 1.8)+32);
                self.desiredTempLabel.text = [NSString stringWithFormat:@"%d", self.desiredTemperature];
            }
            else if (self.currentMode == 0)
            {
                NSString *desiredTemp = [device.attributes[@"heat-setpoint"] objectForKey:@"value"];
                self.desiredTemperature = ([desiredTemp intValue]/2 -40);
                self.desiredTemperature = ((self.desiredTemperature * 1.8)+32);
                self.desiredTempLabel.text = [NSString stringWithFormat:@"%d", self.desiredTemperature];
            }
            else
            {
                NSString *desiredTemp = @"--";
                self.desiredTemperature = 0;
                self.desiredTempLabel.text = desiredTemp;
            }
            
            self.desiredTempStepper.value = self.desiredTemperature;
        }
    }
    // Save a Copy
    self.thermostatDevices = [thermostatDevices copy];
}

@end
