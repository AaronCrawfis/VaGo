//
//  VC_Doors.m
//  ATT_Hack_2015
//
//  Created by Aaron Crawfis on 10/2/15.
//  Copyright © 2015 Aaron Crawfis. All rights reserved.
//

#import "VC_Doors.h"

@interface VC_Doors ()

@end

@implementation VC_Doors

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Get Status of Door Locks
    self.frontDoorLocked = false;
    self.backDoorLocked = false;
    
    // Set Switches to Match
    [self.frontDoorSwitch setOn:self.frontDoorLocked];
    [self.backDoorSwitch setOn:self.backDoorLocked];
    
    // Get Status of Doors
    self.frontDoorOpen = false;
    self.backDoorOpen = false;
    self.garageDoorOpen = false;
    
    // Set Text of Doors
    // Front Door
    if (self.frontDoorOpen) self.frontDoorLabel.textColor = [UIColor redColor];
    else self.frontDoorLabel.textColor = [UIColor greenColor];
    // Back Door
    if (self.backDoorOpen) self.backDoorLabel.textColor = [UIColor redColor];
    else self.backDoorLabel.textColor = [UIColor greenColor];
    // Garage Door
    if (self.garageDoorOpen)
    {
        self.garageDoorLabel.textColor = [UIColor redColor];
        [self.garageDoorButton setTitle:@"Close" forState:UIControlStateNormal];
    }
    else
    {
        self.garageDoorLabel.textColor = [UIColor greenColor];
        [self.garageDoorButton setTitle:@"Open" forState:UIControlStateNormal];
    }
    
    // get Status of Windows
    self.kitchenWindowOpen = false;
    self.masterBedroomWindowOpen = false;
    self.bedroomAWindowOpen = false;
    
    // Set Text of Windows
    // Kitchen
    if (self.kitchenWindowOpen) self.kitchenWindowLabel.textColor = [UIColor redColor];
    else self.kitchenWindowLabel.textColor = [UIColor greenColor];
    // Master Bedroom
    if (self.masterBedroomWindowOpen) self.masterWindowLabel.textColor = [UIColor redColor];
    else self.masterWindowLabel.textColor = [UIColor greenColor];
    // Bedroom A
    if (self.bedroomAWindowOpen) self.bedroomAWindowLabel.textColor = [UIColor redColor];
    else self.bedroomAWindowLabel.textColor = [UIColor greenColor];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)frontDoorSwitch:(UISwitch *)sender
{
}

- (IBAction)backDoorSwitch:(UISwitch *)sender
{
}

- (IBAction)garageDoorSwitch:(UISwitch *)sender
{
}

- (IBAction)garageDoorButtonPressed:(UIButton *)sender
{
}

#pragma mark - Functions


@end
