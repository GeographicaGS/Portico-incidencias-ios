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
#import "ListIncidencesViewController.h"
//#import "PruebaViewController.h"


/*@interface LogingViewController ()
{
    UINavigationController *navController;
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
    
    
    userName.text = @"hector.garcia@geographica.gs";
    userPassword.text = @"yesterday";
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
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
    [[UserHelper getInstance]setUsuario:userName.text];
    [[UserHelper getInstance]setContrasenia:userPassword.text];
    [scrollView setAlpha:0.1];
    [spinner setHidden:FALSE];
    [UserModel initSesion:userName.text password:userPassword.text funcion:@selector(afterInitSesion:) fromObject:self];
}

-(void) afterInitSesion: (NSDictionary*) json
{
    [scrollView setAlpha:1];
    [spinner setHidden:TRUE];
    
    if([json objectForKey:@"error"])
    {
        userName.text = @"";
        userPassword.text = @"";
    }
    else
    {
        UITabBarController *tabBarController = [self.storyboard instantiateViewControllerWithIdentifier:@"tabBarController"];
        
        UITabBar *tabBar = tabBarController.tabBar;
        UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
        UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
        UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
        
        tabBarItem1.title = NSLocalizedString(@"###incidencias###", nil);
        tabBarItem2.title = NSLocalizedString(@"###municipios###", nil);
        tabBarItem3.title = NSLocalizedString(@"###usuario###", nil);
        
        [tabBarItem1 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                            [UIColor colorWithRed:247/255.0 green:77/255.0 blue:41/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                            nil] forState:UIControlStateNormal];
        
        [tabBarItem2 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                             [UIColor colorWithRed:247/255.0 green:77/255.0 blue:41/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                             nil] forState:UIControlStateNormal];
        
        [tabBarItem3 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                             [UIColor colorWithRed:247/255.0 green:77/255.0 blue:41/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                             nil] forState:UIControlStateNormal];
       
        [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"POR_menu_icon_incidencias_ON.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"POR_menu_icon_incidencias_OFF.png"]];
        [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"POR_menu_icon_municipios_ON.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"POR_menu_icon_municipios_OFF.png"]];
        [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"POR_menu_icon_usuario_ON.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"POR_menu_icon_usuario_OFF.png"]];
       
        [self presentViewController:tabBarController animated:YES completion:nil];
        
    }

}

@end
