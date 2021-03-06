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
#import "CellIncidenceModel.h"
#import "IncidenceViewController.h"
#import "MapViewController.h"
#import "IncidenceModel.h"

@interface ListIncidencesViewController ()

@end

TableHelperIncidencias *tablaHelperIncidencias;
TableHelperIncidencias *tablaHelperUsuarios;

@implementation ListIncidencesViewController

@synthesize navigationBar, botonNuevaIncidencia, labelNavigationBar, tablaIncidencias, tablaIncidenciaUsuario, segment, searchBar, spinnerCentral, spinnerViewInferior, spinnerInferior;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [labelNavigationBar setText:NSLocalizedString(@"###incidencias###", nil)];
    [botonNuevaIncidencia setTitle:NSLocalizedString(@"###nueva###", nil)];
    [segment setTitle:NSLocalizedString(@"###recientes###", nil) forSegmentAtIndex:0];
    [segment setTitle:NSLocalizedString(@"###cercanas###", nil) forSegmentAtIndex:1 ];
    self.recargaListado = true;
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    
  
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if(self.recargaListado){
        [self.tablaIncidencias setContentOffset:CGPointMake(0,44) animated:YES];
        [self.tablaIncidenciasMunicipios setContentOffset:CGPointMake(0,44) animated:YES];
        [self.tablaIncidenciaUsuario setContentOffset:CGPointMake(0,44) animated:YES];
        
        [tablaIncidencias setHidden:false];
        [tablaIncidenciaUsuario setHidden:true];

        tablaHelperIncidencias = [self inicializaTablaHelper];
        tablaHelperIncidencias.tablaDatos = tablaIncidencias;
        tablaIncidencias.delegate = tablaHelperIncidencias;
        searchBar.delegate = tablaHelperIncidencias;
        tablaIncidencias.dataSource = tablaHelperIncidencias;
    }
    
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if(self.recargaListado){
    
        NSUInteger selectedIndex = self.tabBarController.selectedIndex;
        
        if(selectedIndex == 0)
        {
            if([segment selectedSegmentIndex] == 0)
            {
                tablaHelperIncidencias.tipoListado = INCIDENCIAS_RECIENTES;
            }
            else
            {
                [[LocationHelper getInstance]getCurrentLocation:@selector(afterGetCurrentLocation:) fromObject:self];
            }
            
        }
        else if (selectedIndex == 1)
        {
            tablaHelperIncidencias.idMunicipio = self.idMunicipio;
            if([segment selectedSegmentIndex] == 0)
            {
                tablaHelperIncidencias.tipoListado = INCIDENCIAS_MUNICIPIOS_RECIENTES;
            }
            else
            {
                [[LocationHelper getInstance]getCurrentLocation:@selector(afterGetCurrentLocation:) fromObject:self];
            }
            
            
        }
        else
        {
            tablaHelperIncidencias.estado = self.estado;
            tablaHelperIncidencias.idMunicipio = self.idMunicipio;
            if([segment selectedSegmentIndex] == 0)
            {
                tablaHelperIncidencias.tipoListado = INCIDENCIAS_USUARIO_RECIENTES;
            }
            else
            {
                [[LocationHelper getInstance]getCurrentLocation:@selector(afterGetCurrentLocation:) fromObject:self];
            }
        }
        
        [self.spinnerCentral setHidden:false];
        [tablaHelperIncidencias cargarDatos];
    }
    else
    {
        self.recargaListado = true;
    }
    
}


- (TableHelperIncidencias*) inicializaTablaHelper
{
    TableHelperIncidencias *tablaHelper = [[TableHelperIncidencias alloc]init];
    
    tablaHelper = [[TableHelperIncidencias alloc]init];
    tablaHelper.spinnerViewInferior = spinnerViewInferior;
    tablaHelper.spinnerInferior = spinnerInferior;
    tablaHelper.spinnerCentral = spinnerCentral;
    tablaHelper.searchBar = searchBar;
    
    return tablaHelper;
}

- (IBAction)segmentEvent:(id)sender {
    NSUInteger selectedIndex = self.tabBarController.selectedIndex;
    
    [spinnerInferior setHidden:true];
    [tablaHelperIncidencias.arrayDatos removeAllObjects];
    [tablaIncidencias reloadData];
    [tablaHelperIncidencias.spinnerCentral setHidden:false];
    tablaHelperIncidencias.finLista = false;
    tablaHelperIncidencias.offset = 0;
    
    if([segment selectedSegmentIndex] == 0)
    {
        if(selectedIndex == 0)
        {
            tablaHelperIncidencias.tipoListado = INCIDENCIAS_RECIENTES;
            
        }
        else if(selectedIndex == 1)
        {
            tablaHelperIncidencias.tipoListado = INCIDENCIAS_MUNICIPIOS_RECIENTES;
        }
        else
        {
            tablaHelperIncidencias.tipoListado = INCIDENCIAS_USUARIO_RECIENTES;
        }
        [tablaHelperIncidencias cargarDatos];
        
    }
    else
    {
        [[LocationHelper getInstance]getCurrentLocation:@selector(afterGetCurrentLocation:) fromObject:self];
    }
}

- (IBAction)segmentEvenUser:(id)sender {
    [spinnerInferior setHidden:true];
    [tablaHelperUsuarios.arrayDatos removeAllObjects];
    [tablaIncidenciaUsuario reloadData];
    [tablaHelperUsuarios.spinnerCentral setHidden:false];
    tablaHelperUsuarios.finLista = false;
    tablaHelperUsuarios.offset = 0;
    
    if([segment selectedSegmentIndex] == 0)
    {
        tablaHelperUsuarios.tipoListado = INCIDENCIAS_USUARIO_RECIENTES;
        [tablaHelperUsuarios cargarDatos];
        
    }
    else
    {
        [[LocationHelper getInstance]getCurrentLocation:@selector(afterGetCurrentLocationUser:) fromObject:self];
    }
}

- (void) afterGetCurrentLocation: (CLLocation*) currentLocation
{

    
    NSUInteger selectedIndex = self.tabBarController.selectedIndex;
    
    if(selectedIndex == 0)
    {
        tablaHelperIncidencias.tipoListado = INDICENCIAS_CERCANAS;
        
    }else if(selectedIndex == 1){
        tablaHelperIncidencias.tipoListado = INCIDENCIAS_MUNICIPIOS_CERCANAS;
    }
    else
    {
        tablaHelperIncidencias.tipoListado = INCIDENCIAS_USUARIO_CERCANAS;
    }
    
    tablaHelperIncidencias.currentLocation = currentLocation;
    [tablaHelperIncidencias cargarDatos];
}

- (void) afterGetCurrentLocationUser: (CLLocation*) currentLocation
{
    
   /*  NSUInteger selectedIndex = self.tabBarController.selectedIndex;
    
    if(selectedIndex == 0)
    {
        tablaHelperIncidencias.tipoListado = INCIDENCIAS_USUARIO_CERCANAS;
        
    }else if(selectedIndex == 1){
        tablaHelperIncidencias.tipoListado = INCIDENCIAS_MUNICIPIOS_CERCANAS;
    }
    
    tablaHelperUsuarios.currentLocation = currentLocation;
    [tablaHelperUsuarios cargarDatos];*/
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"segueIncidence"])
    {
        CellIncidenceModel * cell = sender;
        IncidenceViewController *incidenceView = [segue destinationViewController];
        [incidenceView setIncidencia:cell];
        self.recargaListado = false;
        
    }else if ([[segue identifier] isEqualToString:@"segueMap"]){
        MapViewController *map = [segue destinationViewController];
        [map setNavigate:true];
        [IncidenceModel getGeoJsonIncidenciasByDist:@selector(afterGetAllIncidences:) fromObject:map];
        self.recargaListado = false;
        
    }else if ([[segue identifier] isEqualToString:@"segueNewIncidence"]){
        

    }
}

@end
