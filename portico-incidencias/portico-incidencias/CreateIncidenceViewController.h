//
//  CreateIncidenceViewController.h
//  Pórtico incidencias
//
//  Created by Javier Aragón on 21/04/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface CreateIncidenceViewController : UIViewController<UITextViewDelegate, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrainScroll;
@property (weak, nonatomic) IBOutlet UIButton *doPhotoButton;
@property (weak, nonatomic) IBOutlet UIButton *selectPhotoButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIView *photoView;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *imageViewButton;
@property (weak, nonatomic) IBOutlet UIView *imagenContentView;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrainScrollImages;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrainImageContentView;
@property (weak, nonatomic) IBOutlet UIScrollView *imageViewScroll;

@property (strong, atomic) ALAssetsLibrary* library;
@property (weak, nonatomic) IBOutlet UILabel *typology;
@property NSNumber *idTypology;

- (IBAction)backgroundTouched:(id)sender;
- (IBAction)getCurrenLocation:(id)sender;
- (IBAction)createIncidence:(id)sender;
- (IBAction)showPhotoPanel:(id)sender;
- (IBAction)cancelPhotoAnimation:(id)sender;
- (IBAction)doPhoto:(id)sender;
- (IBAction)selectPhoto:(id)sender;



- (void) afterGetCurrentLocation: (CLLocation*) currentLocation;
- (void) afterCreateIncidence: (NSDictionary*) json;


@end
