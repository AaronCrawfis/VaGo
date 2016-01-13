//
//  VC_Doors.m
//  ATT_Hack_2015
//
//  Created by Aaron Crawfis on 10/2/15.
//  Copyright © 2015 Aaron Crawfis. All rights reserved.
//

#import "VC_Doors.h"
#import "DLClient.h"
#import "Constants.h"
#import "DLeServiceConnection.h"
#import "DLDevice.h"

@interface VC_Doors ()

@end

@implementation VC_Doors

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
    
    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self
                                                selector:@selector(loadDevices) userInfo:nil repeats:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)frontDoorSwitch:(UISwitch *)sender
{
    if(self.frontDoorLocked)
    {
        self.frontDoorLocked = false;
        self.lockState = @"unlock";
    }
    else
    {
        self.frontDoorLocked = true;
        self.lockState = @"lock";
        
    }
    
    for (DLDevice *lockDevice in self.doorLockDevices)
    {
        [[DLClient shared] updateDeviceWithDeviceID:lockDevice.deviceGuid forAction:@"lock" withValue:self.lockState completionHandler:^ (BOOL success, NSNumber *transactionID) {
            // if there was no transaction id then the switch was already set to the value we requested, otherwise we mark the device as having a pending change on the "switch" label
            if (transactionID && (transactionID.integerValue != -1))
            {
                NSLog(@"Door Switched");
            }
            else
            {
                NSLog(@"Nothing Happened");
            }
        }]; // End of [DLClient]
    }

}

- (IBAction)backDoorSwitch:(UISwitch *)sender
{
}

- (IBAction)garageDoorSwitch:(UISwitch *)sender
{
    if(self.garageDoorOpen)
    {
        self.garageDoorOpen = false;
        self.garageState = @"close";
    }
    else
    {
        self.garageDoorOpen = true;
        self.garageState = @"open";
        
    }
    
    for (DLDevice *garageDevice in self.garageDevices)
    {
        [[DLClient shared] updateDeviceWithDeviceID:garageDevice.deviceGuid forAction:@"garage-door-control" withValue:self.garageState completionHandler:^ (BOOL success, NSNumber *transactionID) {
            // if there was no transaction id then the switch was already set to the value we requested, otherwise we mark the device as having a pending change on the "switch" label
            if (transactionID && (transactionID.integerValue != -1))
            {
                NSLog(@"Garage Switched");
            }
            else
            {
                NSLog(@"Nothing Happened");
            }
        }]; // End of [DLClient]
    }

}

#pragma mark - Functions

- (void) searchDevices
{
    NSLog(@"Searching for Devices");
    
    // Add Devices
    NSMutableArray *sensorDevices = [[NSMutableArray alloc] init];
    NSMutableArray *lockDevices = [[NSMutableArray alloc] init];
    NSMutableArray *garageDevices = [[NSMutableArray alloc] init];
    NSArray *allDevices = [[DLClient shared] devices];
    for (DLDevice *device in allDevices)
    {
        if (([device.deviceType isEqualToString:@"contact-sensor"] && device.attributes[@"status"] != nil))
        {
            NSLog(@"Contact Sensor Found");
            [sensorDevices addObject:device];
        }
        else if (([device.deviceType isEqualToString:@"door-lock"] && device.attributes[@"status"] != nil))
        {
            NSLog(@"Lock Found");
            [lockDevices addObject:device];
        }
        else if (([device.deviceType isEqualToString:@"garage-door-controller"] && device.attributes[@"status"] != nil))
        {
            NSLog(@"Garage Door Found");
            [garageDevices addObject:device];
        }
    }
    // Save a Copy
    self.sensorDevices = [sensorDevices copy];
    self.doorLockDevices = [lockDevices copy];
    self.garageDevices = [garageDevices copy];
    
    // Update Text Information
    [self setText:sensorDevices];
    [self setSwitches:lockDevices];
}

- (void) setText:(NSArray *)devices
{
    for (DLDevice *device in devices)
    {
        if ([[device.attributes[@"name"] objectForKey:@"value"] isEqual:@"Contact Window1"])
        {
           if ([[device.attributes[@"contact-state"] objectForKey:@"value"] isEqual:@"closed"])
           {
               self.kitchenWindowOpen = false;
               self.kitchenWindowLabel.textColor = [UIColor greenColor];
           }
           else self.kitchenWindowLabel.textColor = [UIColor redColor];
        }
        else if ([[device.attributes[@"name"] objectForKey:@"value"] isEqual:@"Contact Window2"])
        {
            if ([[device.attributes[@"contact-state"] objectForKey:@"value"] isEqual:@"closed"])
            {
                self.masterBedroomWindowOpen = false;
                self.masterWindowLabel.textColor = [UIColor greenColor];
            }
            else self.masterWindowLabel.textColor = [UIColor redColor];
        }
        else if ([[device.attributes[@"name"] objectForKey:@"value"] isEqual:@"Contact Window3"])
        {
            if ([[device.attributes[@"contact-state"] objectForKey:@"value"] isEqual:@"closed"])
            {
                self.bedroomAWindowOpen = false;
                self.bedroomAWindowLabel.textColor = [UIColor greenColor];
            }
            else self.bedroomAWindowLabel.textColor = [UIColor redColor];
        }
        else if ([[device.attributes[@"name"] objectForKey:@"value"] isEqual:@"Contact Door1"])
        {
            if ([[device.attributes[@"contact-state"] objectForKey:@"value"] isEqual:@"closed"])
            {
                self.frontDoorOpen = false;
                self.frontDoorLabel.textColor = [UIColor greenColor];
            }
            else self.frontDoorLabel.textColor = [UIColor redColor];
        }
        else if ([[device.attributes[@"name"] objectForKey:@"value"] isEqual:@"Contact Door2"])
        {
            if ([[device.attributes[@"contact-state"] objectForKey:@"value"] isEqual:@"closed"])
            {
                self.backDoorOpen = false;
                self.backDoorLabel.textColor = [UIColor greenColor];
            }
            else self.backDoorLabel.textColor = [UIColor redColor];
        }
        else if ([[device.attributes[@"name"] objectForKey:@"value"] isEqual:@"Contact Door3"])
        {
            if ([[device.attributes[@"contact-state"] objectForKey:@"value"] isEqual:@"closed"])
            {
                self.garageDoorOpen = false;
                self.garageDoorLabel.textColor = [UIColor greenColor];
            }
            else self.garageDoorLabel.textColor = [UIColor redColor];
        }
    }
}

- (void) setSwitches:(NSArray *)devices
{
    for (DLDevice *device in devices)
    {
        if ([[device.attributes[@"name"] objectForKey:@"value"] isEqual:@"Door Lock"])
        {
            if ([[device.attributes[@"lock"] objectForKey:@"value"] isEqual:@"unlock"])
            {
                self.frontDoorLocked = false;
                [self.frontDoorSwitch setOn:NO];
            }
            else
            {
                self.frontDoorLocked = true;
                [self.frontDoorSwitch setOn:YES];
            }
        }
        else if ([[device.attributes[@"name"] objectForKey:@"value"] isEqual:@"Garage Door Opener"])
        {
            if ([[device.attributes[@"garage-door-state"] objectForKey:@"value"] isEqual:@"open"])
            {
                self.garageDoorOpen = true;
                [self.frontDoorSwitch setOn:NO];
            }
            else
            {
                self.garageDoorOpen = false;
                [self.frontDoorSwitch setOn:YES];
            }
        }
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



@end
