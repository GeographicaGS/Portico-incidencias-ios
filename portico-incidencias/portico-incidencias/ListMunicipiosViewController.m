//
//  ListMunicipiosViewController.m
//  Pórtico incidencias
//
//  Created by Javier Aragón on 17/02/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import "ListMunicipiosViewController.h"
#import "TableHelperMunicipios.h"
#import "ListIncidencesViewController.h"
#import "CellIncidenceTownModel.h"

@interface ListMunicipiosViewController ()

@end

TableHelperMunicipios *tablaHelperMunicipios;

@implementation ListMunicipiosViewController

@synthesize tablaMunicipios, searchBar, spinnerCentral, spinnerViewInferior, labelNavigationBar;

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
    
    [labelNavigationBar setText:NSLocalizedString(@"###municipios###", nil)];
    [spinnerCentral setHidden:false];
    tablaHelperMunicipios = [[TableHelperMunicipios alloc]init];
    tablaHelperMunicipios.spinnerViewInferior = spinnerViewInferior;
    tablaHelperMunicipios.spinnerCentral = spinnerCentral;
    tablaHelperMunicipios.searchBar = searchBar;
    tablaHelperMunicipios.tablaDatos = tablaMunicipios;
    tablaMunicipios.delegate = tablaHelperMunicipios;
    tablaMunicipios.dataSource = tablaHelperMunicipios;
    searchBar.delegate = tablaHelperMunicipios;
    [tablaHelperMunicipios cargarDatos];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tablaMunicipios setContentOffset:CGPointMake(0,44) animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    CellIncidenceTownModel * cell = sender;
    if([cell.numIncidencias.text isEqualToString:@"0"]){
        return NO;
    }
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CellIncidenceTownModel * cell = sender;
    ListIncidencesViewController *list = [segue destinationViewController];
    [list setIdMunicipio:cell.idMunicipio];
}


@end
