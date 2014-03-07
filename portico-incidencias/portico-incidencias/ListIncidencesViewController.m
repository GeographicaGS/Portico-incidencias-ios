//
//  ListIncidencesViewController.m
//  Pórtico incidencias
//
//  Created by Javier Aragón on 10/02/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import "ListIncidencesViewController.h"
#import "TableHelperIncidencias.h"
#import "LocationHelper.h"
#import "Constants.h"

@interface ListIncidencesViewController ()

@end

TableHelperIncidencias *tablaHelperIncidencias;
TableHelperIncidencias *tablaHelperUsuarios;

@implementation ListIncidencesViewController

@synthesize navigationBar, botonNuevaIncidencia, labelNavigationBar, tablaIncidencias, tablaIncidenciaUsuario, segment, searchBar, spinnerCentral, spinnerViewInferior;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [labelNavigationBar setText:NSLocalizedString(@"###incidencias###", nil)];
    [botonNuevaIncidencia setTitle:NSLocalizedString(@"###nueva###", nil)];
    [segment setTitle:NSLocalizedString(@"###recientes###", nil) forSegmentAtIndex:0];
    [segment setTitle:NSLocalizedString(@"###cercanas###", nil) forSegmentAtIndex:1 ];

    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    
    NSUInteger selectedIndex = self.tabBarController.selectedIndex;
    if(selectedIndex == 0)
    {
        [tablaIncidencias setHidden:false];
        [tablaIncidenciaUsuario setHidden:true];
        
        tablaHelperIncidencias = [self inicializaTablaHelper];
        tablaHelperIncidencias.tipoListado = INCIDENCIAS_RECIENTES;
        tablaHelperIncidencias.tablaDatos = tablaIncidencias;
        tablaIncidencias.delegate = tablaHelperIncidencias;
        searchBar.delegate = tablaHelperIncidencias;
        tablaIncidencias.dataSource = tablaHelperIncidencias;
        [tablaHelperIncidencias cargarDatos];
    }
    else if (selectedIndex == 1)
    {
        

    }
    else
    {
        [tablaIncidencias setHidden:false];
        [tablaIncidenciaUsuario setHidden:false];
        
        tablaHelperUsuarios = [self inicializaTablaHelper];
        tablaHelperUsuarios.tipoListado = INCIDENCIAS_USUARIO_RECIENTES;
        tablaHelperUsuarios.tablaDatos = tablaIncidenciaUsuario;
        tablaIncidenciaUsuario.delegate = tablaHelperUsuarios;
        tablaIncidenciaUsuario.dataSource = tablaHelperUsuarios;
        [tablaHelperUsuarios cargarDatos];
    }
}

- (TableHelperIncidencias*) inicializaTablaHelper
{
    TableHelperIncidencias *tablaHelper = [[TableHelperIncidencias alloc]init];
    
    tablaHelper = [[TableHelperIncidencias alloc]init];
    tablaHelper.spinnerViewInferior = spinnerViewInferior;
    tablaHelper.spinnerCentral = spinnerCentral;
    tablaHelper.searchBar = searchBar;
    
    return tablaHelper;
}


- (IBAction)segmentEvent:(id)sender {
    
    [tablaHelperIncidencias.arrayDatos removeAllObjects];
    [tablaIncidencias reloadData];
    [tablaHelperIncidencias.spinnerCentral setHidden:false];
    tablaHelperIncidencias.finLista = false;
    tablaHelperIncidencias.offset = 0;
    
    if([segment selectedSegmentIndex] == 0)
    {
        tablaHelperIncidencias.tipoListado = INCIDENCIAS_RECIENTES;
        [tablaHelperIncidencias cargarDatos];
        
    }
    else
    {
        [[LocationHelper getInstance]getCurrentLocation:@selector(afterGetCurrentLocation:) fromObject:self];
    }
}

- (void) afterGetCurrentLocation: (CLLocation*) currentLocation
{
    tablaHelperIncidencias.currentLocation = currentLocation;
    tablaHelperIncidencias.tipoListado = INDICENCIAS_CERCANAS;
    [tablaHelperIncidencias cargarDatos];
}

@end
