//
//  VC_Maps.m
//  ATT_Hack_2015
//
//  Created by Aaron Crawfis on 10/3/15.
//  Copyright © 2015 Aaron Crawfis. All rights reserved.
//

#import "VC_Maps.h"
#import <CoreLocation/CoreLocation.h>
#import "foodObject.h"

#define METERS_PER_MILE 1609.344

@interface VC_Maps ()

@end

@implementation VC_Maps

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self.mapView setDelegate:self];
    
    
    [self createData];
    [self updateMap];
    
}



- (void)viewWillAppear:(BOOL)animated {
    // 1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 41.692663;
    zoomLocation.longitude= -86.238675;
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    // 3
    [_mapView setRegion:viewRegion animated:YES];
    
}

- (IBAction)backButtonPressed:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)updateMap

{
    self.first = true;
    
    for (foodObject *food in self.foodList)
    {
        NSString *location = [NSString stringWithFormat:@"%@ %@, %@ %@", food.address, food.city, food.state, food.zipcode];
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder geocodeAddressString:location completionHandler:^(NSArray* placemarks, NSError* error)
         {
             if (placemarks && placemarks.count > 0) {
                 CLPlacemark *topResult = [placemarks objectAtIndex:0];
                 MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
                 
                 MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
                 point.coordinate = placemark.coordinate;
                 point.title = food.name;
                 //point.subtitle = [NSString stringWithFormat:@"%@,%@",venue.city,venue.state];
                 
                 CLLocationCoordinate2D zoomLocation;
                 zoomLocation.latitude = 41.692663;
                 zoomLocation.longitude=  -86.238675;
                 
                 MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
                 
                 if (self.first)
                 {
                     [self.mapView setRegion:viewRegion animated:YES];
                     self.first = false;
                 }
                 
                 
                 [self.mapView addAnnotation:point];
             }
         }];
        
    }
    
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    
    if (pinView ==nil) {
        
        pinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"Pin"];
        pinView.animatesDrop = YES;
        pinView.canShowCallout = YES;
    }
    
    return pinView;
}


- (void) createData
{
    foodObject *food1 = [[foodObject alloc] init];
    food1.name = @"Legends";
    food1.address = @"447 Eddy Street";
    food1.city = @"Notre Dame";
    food1.state = @"Indiana";
    food1.zipcode = @"46556";
    
    foodObject *food2 = [[foodObject alloc] init];
    food2.name = @"Five Guys";
    food2.address = @"";
    food2.city = @"South Bend";
    food2.state = @"Indiana";
    food2.zipcode = @"46601";
    
    foodObject *food3 = [[foodObject alloc] init];
    food3.name = @"Barbici";
    food3.address = @"1235 N Eddy Street";
    food3.city = @"South Bend";
    food3.state = @"Indiana";
    food3.zipcode = @"";
    
    foodObject *food4 = [[foodObject alloc] init];
    food4.name = @"The Mark";
    food4.address = @"1234 N Eddy Street";
    food4.city = @"South Bend";
    food4.state = @"Indiana";
    food4.zipcode = @"46601";
    
    foodObject *food5 = [[foodObject alloc] init];
    food5.name = @"Brothers Bar & Grill";
    food5.address = @"1112 N Eddy Street";
    food5.city = @"South Bend";
    food5.state = @"Indiana";
    food5.zipcode = @"46601";
    
    NSMutableArray *foodArray = [[NSMutableArray alloc] init];
    [foodArray addObject:food1];
    [foodArray addObject:food2];
    [foodArray addObject:food3];
    [foodArray addObject:food4];
    [foodArray addObject:food5];
    
    self.foodList = [foodArray copy];
    
}

@end
