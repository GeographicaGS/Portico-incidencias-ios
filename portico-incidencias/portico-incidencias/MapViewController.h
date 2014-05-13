//
//  MapViewController.h
//  Pórtico incidencias
//
//  Created by Javier Aragón on 31/03/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController : UIViewController <GMSMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UILabel *labelNavigationBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nuevaIncidenciaButton;
@property (weak, nonatomic) IBOutlet UIView *infoWindow;
@property (weak, nonatomic) IBOutlet UIView *imgeOrangeInfoWindow;
@property (weak, nonatomic) IBOutlet UILabel *labelFirstInfoWindow;
@property (weak, nonatomic) IBOutlet UILabel *labelSecondInfoWindow;
@property (weak, nonatomic) IBOutlet UIButton *butonGoIncidence;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;

- (void) afterGetCurrentLocation: (CLLocation*) currentLocation;
- (void) afterGetAllIncidences: (NSDictionary*) json;
- (IBAction)goBack:(id)sender;


@property (nonatomic) BOOL *navigate;;


@end
