//
//  ListIncidencesViewController.h
//  Pórtico incidencias
//
//  Created by Javier Aragón on 10/02/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ListIncidencesViewController : UIViewController
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *botonNuevaIncidencia;
@property (weak, nonatomic) IBOutlet UILabel *labelNavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *tablaIncidencias;
@property (weak, nonatomic) IBOutlet UITableView *tablaIncidenciasMunicipios;
@property (weak, nonatomic) IBOutlet UITableView *tablaIncidenciaUsuario;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIView *spinnerViewInferior;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinnerCentral;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinnerInferior;

@property NSNumber *idMunicipio;
@property int estado;

- (IBAction)segmentEvent:(id)sender;
- (IBAction)segmentEvenUser:(id)sender;
- (void) afterGetCurrentLocation: (CLLocation*) currentLocation;
- (void) afterGetCurrentLocationUser: (CLLocation*) currentLocation;

@end
