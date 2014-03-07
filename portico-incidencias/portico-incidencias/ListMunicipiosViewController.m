//
//  ListMunicipiosViewController.m
//  Pórtico incidencias
//
//  Created by Javier Aragón on 17/02/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import "ListMunicipiosViewController.h"
#import "TableHelperMunicipios.h"

@interface ListMunicipiosViewController ()

@end

TableHelperMunicipios *tablaHelperMunicipios;

@implementation ListMunicipiosViewController

@synthesize tablaMunicipios, searchBar, spinnerCentral, spinnerViewInferior;

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
    
    [spinnerCentral setHidden:true];
    tablaHelperMunicipios = [[TableHelperMunicipios alloc]init];
    tablaHelperMunicipios.spinnerViewInferior = spinnerViewInferior;
    tablaHelperMunicipios.spinnerCentral = spinnerCentral;
    tablaHelperMunicipios.searchBar = searchBar;
    tablaHelperMunicipios.tablaDatos = tablaMunicipios;
    tablaMunicipios.delegate = tablaHelperMunicipios;
    tablaMunicipios.dataSource = tablaHelperMunicipios;
    [tablaHelperMunicipios cargarDatos];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
