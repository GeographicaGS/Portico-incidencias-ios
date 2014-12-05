//
//  LocationHelper.h
//  Pórtico incidencias
//
//  Created by Javier Aragón on 03/03/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationHelper : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

+ (id)getInstance;

- (void) getCurrentLocation: (SEL)func fromObject:(id) object;;


@end
