//
//  LocationHelper.m
//  Pórtico incidencias
//
//  Created by Javier Aragón on 03/03/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import "LocationHelper.h"
#import <CoreLocation/CLGeocoder.h>

@implementation LocationHelper

CLLocationManager *locationManager;
SEL funcion;
id clase;

+ (id)getInstance
{
    
    static LocationHelper *instance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        locationManager = [[CLLocationManager alloc]init];
        instance = [[LocationHelper alloc] init];
    });
    
    return instance;
}


- (void) getCurrentLocation: (SEL)func fromObject:(id) object
{
    funcion = func;
    clase = object;
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation* currentLocation = [locations lastObject];
    if(currentLocation != nil)
    {
        [clase performSelector:funcion withObject:currentLocation];
        [locationManager stopUpdatingLocation];
        [locationManager stopUpdatingHeading];
        [locationManager stopMonitoringSignificantLocationChanges];
    }
    
}



@end
