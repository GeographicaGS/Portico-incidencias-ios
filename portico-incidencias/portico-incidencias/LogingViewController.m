//
//  LogingViewController.m
//  Pórtico incidencias
//
//  Created by Javier Aragón on 03/02/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import "Header.h"
#import "UserModel.h"
#import "LogingViewController.h"


/*@interface LogingViewController ()
{
    UITextField *userName;
    UITextField *userPassword;
}

@end*/



@implementation LogingViewController

@synthesize scrollView, userName, userPassword, botonIniciarSesion, botonComunicarProblema, spinner;



-(void)viewDidLoad
{
    self.view.backgroundColor = [[UIColor alloc]initWithRed:(74/255.0) green:(60/255.0) blue:(49/255.0) alpha:1.0];
    [userName setPlaceholder:NSLocalizedString(@"###correoElectronico###", nil)];
    userName.delegate = self;
    [userPassword setPlaceholder:NSLocalizedString(@"###contraseña###", nil)];
    userPassword.delegate = self;
    [botonIniciarSesion setTitle: NSLocalizedString(@"###inciarSesion###", nil) forState:UIControlStateNormal];
    [[botonIniciarSesion layer] setCornerRadius:3];
    [botonComunicarProblema setTitle: NSLocalizedString(@"###comunicarProblema###", nil) forState:UIControlStateNormal];
    
    [super viewWillAppear:YES];
    
   
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    [scrollView setContentOffset:CGPointMake(0,85) animated:YES] ;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [scrollView setContentOffset:CGPointMake(0,0) animated:YES];
    
    
    return YES;
}

-(IBAction)backgroundTouched:(id)sender
{
    [userName resignFirstResponder];
    [userPassword resignFirstResponder];
    [scrollView setContentOffset:CGPointMake(0,0) animated:YES];
}

-(IBAction)login:(id)sender
{
    [UserModel initSesion:userName.text password:userPassword.text];
}

@end
