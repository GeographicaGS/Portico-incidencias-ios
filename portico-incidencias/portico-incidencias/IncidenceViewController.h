//
//  IncidenceViewController.h
//  Pórtico incidencias
//
//  Created by Javier Aragón on 14/04/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellIncidenceModel.h"

@interface IncidenceViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBar;
@property (weak, nonatomic) IBOutlet UILabel *labelNavigation;
@property (weak, nonatomic) IBOutlet UILabel *estado;
@property (weak, nonatomic) IBOutlet UIImageView *imgEstado;
@property (weak, nonatomic) IBOutlet UILabel *titulo;
@property (weak, nonatomic) IBOutlet UILabel *municipio;
@property (weak, nonatomic) IBOutlet UIButton *botonIrMapa;
@property (nonatomic, strong) CellIncidenceModel *incidencia;
@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UILabel *labelComent;
@property (weak, nonatomic) IBOutlet UILabel *userComment;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrainScroll;
@property (weak, nonatomic) IBOutlet UIView *actionView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextField *textFieldComment;
@property (weak, nonatomic) IBOutlet UIView *miniSeparator;
@property (weak, nonatomic) IBOutlet UIView *separatorComment;

- (IBAction)backgroundTouched:(id)sender;

- (void) afterGetComments: (NSDictionary*) json;


@end
