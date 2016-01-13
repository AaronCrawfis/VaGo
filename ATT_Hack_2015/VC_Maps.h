//
//  VC_Maps.h
//  ATT_Hack_2015
//
//  Created by Aaron Crawfis on 10/3/15.
//  Copyright © 2015 Aaron Crawfis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface VC_Maps : UIViewController
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)backButtonPressed:(UIButton *)sender;

@property (strong, nonatomic) NSMutableArray *foodList;

@property bool first;
@property bool completed;

@end
