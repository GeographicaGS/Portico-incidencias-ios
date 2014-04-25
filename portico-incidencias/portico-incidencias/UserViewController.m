//
//  UserViewController.m
//  Pórtico incidencias
//
//  Created by Javier Aragón on 25/04/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import "UserViewController.h"

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
    [self.optionLabel setTitle:NSLocalizedString(@"###options###", nil) forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
