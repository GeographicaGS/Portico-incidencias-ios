//
//  LogingViewController.h
//  Pórtico incidencias
//
//  Created by Javier Aragón on 03/02/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogingViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *userPassword;
@property (strong, nonatomic) IBOutlet UIButton *botonIniciarSesion;
@property (strong, nonatomic) IBOutlet UIButton *botonComunicarProblema;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

- (IBAction)backgroundTouched:(id)sender;
- (IBAction)login:(id)sender;

@end
