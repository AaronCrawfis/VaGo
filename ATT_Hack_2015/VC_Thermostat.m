//
//  VC_Thermostat.m
//  ATT_Hack_2015
//
//  Created by Aaron Crawfis on 10/2/15.
//  Copyright © 2015 Aaron Crawfis. All rights reserved.
//

#import "VC_Thermostat.h"

@interface VC_Thermostat ()

@end

@implementation VC_Thermostat

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Get Current Temperature
    self.currentTemperature = 55;
    
    // Update Current Temperature Label
    NSString *cTemp = [NSString stringWithFormat:@"%d",self.currentTemperature];
    self.currentTempLabel.text = cTemp;
    
    // Get Desired Temperature
    self.desiredTemperature = 56;
    
    // Update Desired Temperatre Label
    NSString *dTemp = [NSString stringWithFormat:@"%d", self.desiredTemperature];
    self.desiredTempLabel.text = dTemp;
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

- (IBAction)desiredTempStepperChanged:(UIStepper *)sender
{
    // Update Label to Match Stepper Value
    NSString *temp = [NSString stringWithFormat:@"%d",(int)self.desiredTempStepper.value];
    self.desiredTempLabel.text = temp;
    
    // Send Updated Temperature to Tmermostat
}

@end
