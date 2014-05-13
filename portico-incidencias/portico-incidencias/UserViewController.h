//
//  UserViewController.h
//  Pórtico incidencias
//
//  Created by Javier Aragón on 25/04/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelNavigation;
@property (weak, nonatomic) IBOutlet UILabel *openLabel;
@property (weak, nonatomic) IBOutlet UILabel *resolvelLabel;
@property (weak, nonatomic) IBOutlet UILabel *fieldLabel;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *userAvatar;
@property (weak, nonatomic) IBOutlet UILabel *numAbiertas;
@property (weak, nonatomic) IBOutlet UILabel *numResueltas;
@property (weak, nonatomic) IBOutlet UILabel *numCerradas;
@property (weak, nonatomic) IBOutlet UILabel *userPhone;
@property (weak, nonatomic) IBOutlet UILabel *labelPhone;
@property (weak, nonatomic) IBOutlet UIButton *closeSessionButon;

- (void) afterGetUserInfo: (NSDictionary*) json;
- (IBAction)closeSession:(id)sender;

@end
