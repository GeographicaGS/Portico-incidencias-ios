//
//  CreateIncidenceViewController.h
//  Pórtico incidencias
//
//  Created by Javier Aragón on 21/04/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CreateIncidenceViewController : UIViewController<UITextViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *labelNavigation;
@property (weak, nonatomic) IBOutlet UIView *viewLabelNavigation;
@property (weak, nonatomic) IBOutlet UIButton *createButtom;
@property (weak, nonatomic) IBOutlet UITextField *incidenceTitle;
@property (weak, nonatomic) IBOutlet UITextView *incidenceDescription;
@property (weak, nonatomic) IBOutlet UITextField *latitud;
@property (weak, nonatomic) IBOutlet UITextField *longitud;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property (weak, nonatomic) IBOutlet UIButton *addImageButton;
@property (weak, nonatomic) IBOutlet UIButton *locateButton;

- (IBAction)backgroundTouched:(id)sender;
- (IBAction)getCurrenLocation:(id)sender;
- (IBAction)createIncidence:(id)sender;


- (void) afterGetCurrentLocation: (CLLocation*) currentLocation;
- (void) afterCreateIncidence: (NSDictionary*) json;

@end
