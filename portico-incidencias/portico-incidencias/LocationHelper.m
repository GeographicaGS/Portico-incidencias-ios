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

//CLLocationManager *locationManager;
SEL funcion;
id clase;

+ (id)getInstance
{
    
    static LocationHelper *instance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
//        locationManager = [[CLLocationManager alloc]init];
        instance = [[LocationHelper alloc] init];
    });
    
    return instance;
}


- (void) getCurrentLocation: (SEL)func fromObject:(id) object
{
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [self.locationManager requestWhenInUseAuthorization];
    }

//    [self.locationManager requestAlwaysAuthorization];
    
    funcion = func;
    clase = object;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    [self.locationManager startUpdatingLocation];
    [self.locationManager requestWhenInUseAuthorization];
    
    
    
//    if([CLLocationManager locationServicesEnabled]) {
//        // Location Services Are Enabled
//        switch([CLLocationManager authorizationStatus]) {
//            case kCLAuthorizationStatusNotDetermined:
//                // User has not yet made a choice with regards to this application
////                [self.locationManager requestWhenInUseAuthorization];
//                break;
//            case kCLAuthorizationStatusRestricted:
//                // This application is not authorized to use location services.  Due
//                // to active restrictions on location services, the user cannot change
//                // this status, and may not have personally denied authorization
//                break;
//            case kCLAuthorizationStatusDenied:
//                // User has explicitly denied authorization for this application, or
//                // location services are disabled in Settings
//                break;
//            case kCLAuthorizationStatusAuthorized:
//                // User has authorized this application to use location services
//                break;
//        }
//    } else {
//        // Location Services Disabled
//    }
    
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
        [self.locationManager stopUpdatingLocation];
        [self.locationManager stopUpdatingHeading];
        [self.locationManager stopMonitoringSignificantLocationChanges];
    }
    
}



@end
