//
//  UserViewController.m
//  Pórtico incidencias
//
//  Created by Javier Aragón on 25/04/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import "UserViewController.h"
#import "UserModel.h"
#import "ListIncidencesViewController.h"

@interface UserViewController ()

@end

@implementation UserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.labelNavigation setText:NSLocalizedString(@"###userProfile###", nil)];
    [self.openLabel setText:NSLocalizedString(@"###open###", nil)];
    [self.resolvelLabel setText:NSLocalizedString(@"###resolve###", nil)];
    [self.fieldLabel setText:NSLocalizedString(@"###field###", nil)];
    [self.closeSessionButon setTitle:NSLocalizedString(@"###cerrarSesion###", nil) forState:UIControlStateNormal];
    [self.labelPhone setText:NSLocalizedString(@"###telefono###", nil)];
    
    [UserModel getUserInfo:@selector(afterGetUserInfo:) fromObject:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) afterGetUserInfo: (NSDictionary*) json
{
    self.username.text = [NSMutableString stringWithFormat:@"%@%@%@", [json objectForKey:@"name"], @" ", [json objectForKey:@"surname"]];
    self.userAvatar.text = [json objectForKey:@"email"];
    self.numAbiertas.text = [[json objectForKey:@"abiertas"]stringValue];
    self.numResueltas.text = [[json objectForKey:@"resueltas"] stringValue];
    self.numCerradas.text = [[json objectForKey:@"archivadas"] stringValue];
    self.userPhone.text = [json objectForKey:@"telefono"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ListIncidencesViewController *listIncidencesViewController = [segue destinationViewController];
    [listIncidencesViewController setEstado:(int)[sender tag]];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    int tag = (int)[sender tag];
    if(tag == 0 && [self.numAbiertas.text isEqual:@"0"]){
        return NO;
    }else if(tag == 1 && [self.numResueltas.text isEqual:@"0"]){
        return NO;
    }else if(tag == 2 && [self.numCerradas.text isEqual:@"0"]){
        return NO;
    }
    return YES;
}

- (IBAction)closeSession:(id)sender
{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
