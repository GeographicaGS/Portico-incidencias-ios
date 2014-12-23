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
    
    NSString * userNameAux = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    NSString * passwordAux = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
    
    if(userNameAux!=nil && passwordAux!=nil)
    {
        [[UserHelper getInstance]setUsuario:userNameAux];
        [[UserHelper getInstance]setContrasenia:passwordAux];
        [UserModel initSesion:userNameAux password:passwordAux funcion:@selector(afterInitSesion:) fromObject:self];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [scrollView setContentOffset:CGPointMake(0,210) animated:YES] ;
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

- (IBAction)sendProblem:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://portico.geographica.gs/support"]];
}

-(void) afterInitSesion: (NSDictionary*) json
{
    [scrollView setAlpha:1];
    [spinner setHidden:TRUE];
    
    if([json objectForKey:@"error"])
    {
        userName.text = @"";
        userPassword.text = @"";
        
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
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
                                            nil] forState:UIControlStateSelected];
        
        [tabBarItem2 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                             [UIColor colorWithRed:247/255.0 green:77/255.0 blue:41/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                             nil] forState:UIControlStateSelected];
        
        [tabBarItem3 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                             [UIColor colorWithRed:247/255.0 green:77/255.0 blue:41/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                             nil] forState:UIControlStateSelected];
       

        [tabBarItem1 setSelectedImage:[[UIImage imageNamed:@"POR_menu_icon_incidencias_ON.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [tabBarItem1 setImage:[[UIImage imageNamed:@"POR_menu_icon_incidencias_OFF.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        [tabBarItem2 setSelectedImage:[[UIImage imageNamed:@"POR_menu_icon_municipios_ON.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [tabBarItem2 setImage:[[UIImage imageNamed:@"POR_menu_icon_municipios_OFF.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        [tabBarItem3 setSelectedImage:[[UIImage imageNamed:@"POR_menu_icon_usuario_ON.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [tabBarItem3 setImage:[[UIImage imageNamed:@"POR_menu_icon_usuario_OFF.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        
//        [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"POR_menu_icon_incidencias_ON.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"POR_menu_icon_incidencias_OFF.png"]];
//        [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"POR_menu_icon_municipios_ON.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"POR_menu_icon_municipios_OFF.png"]];
//        [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"POR_menu_icon_usuario_ON.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"POR_menu_icon_usuario_OFF.png"]];
        
        
        [[NSUserDefaults standardUserDefaults] setValue:[[UserHelper getInstance]getUsuario]forKey:@"username"];
        [[NSUserDefaults standardUserDefaults] setValue:[[UserHelper getInstance]getContrasenia] forKey:@"password"];
        [[NSUserDefaults standardUserDefaults] synchronize];
       
        [self presentViewController:tabBarController animated:YES completion:nil];
        
    }

}

@end
