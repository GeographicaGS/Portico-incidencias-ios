//
//  ListMunicipiosViewController.h
//  Pórtico incidencias
//
//  Created by Javier Aragón on 17/02/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListMunicipiosViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tablaMunicipios;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIView *spinnerViewInferior;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinnerCentral;
@property (weak, nonatomic) IBOutlet UILabel *labelNavigationBar;

@end
