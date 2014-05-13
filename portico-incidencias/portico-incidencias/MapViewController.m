//
//  MapViewController.m
//  Pórtico incidencias
//
//  Created by Javier Aragón on 31/03/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import "MapViewController.h"
#import "LocationHelper.h"
#import "IncidenceModel.h"
#import  "CellIncidenceModel.h"
#import "IncidenceViewController.h"
#import "AFHTTPRequestOperation.h"
//#import <Mapbox/Mapbox.h>

@interface MapViewController ()

@end

//RMMapView *mapView;
 GMSMapView *mapView;

@implementation MapViewController
@synthesize mainView, navigationItem, backButton, labelNavigationBar, nuevaIncidenciaButton, infoWindow, imgeOrangeInfoWindow, labelFirstInfoWindow, labelSecondInfoWindow, thumbnail;

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
    //[IncidenceModel getGeoJsonIncidenciasByDist:@selector(afterGetGeoJson:) fromObject:self];
    //[[LocationHelper getInstance]getCurrentLocation:@selector(afterGetCurrentLocation:) fromObject:self];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textColor = [UIColor colorWithRed:(74/255.0) green:(60/255.0) blue:(49/255.0) alpha:1.0];
    label.text = NSLocalizedString(@"###incidencias###", nil);
    self.navigationItem.titleView = label;
    [label sizeToFit];
    
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:imgeOrangeInfoWindow.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerTopLeft) cornerRadii:CGSizeMake(6.0, 6.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = imgeOrangeInfoWindow.bounds;
    maskLayer.path = maskPath.CGPath;
    imgeOrangeInfoWindow.layer.mask = maskLayer;
    
    //[labelNavigationBar setText:NSLocalizedString(@"###incidencias###", nil)];
    [nuevaIncidenciaButton setTitle:NSLocalizedString(@"###nueva###", nil)];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:37.385874
                                                            longitude:-5.984756
                                                                 zoom:9];
    
    mapView = [GMSMapView mapWithFrame:self.mainView.bounds camera:camera];
    mapView.myLocationEnabled = YES;
    
    if(!self.navigate){
        [self.butonGoIncidence setHidden:true];
        nuevaIncidenciaButton.title = NULL;
        backButton.image = [UIImage imageNamed:@"POR_icon_cab_volver.png"];
      
    }
    /*else{
        [self.butonGoIncidence setHidden:false];
    }*/
    
    mapView.delegate = self;
    
    [self.mainView addSubview:mapView];
    
   // [IncidenceModel getGeoJsonIncidenciasByDist:@selector(afterGetGeoJson:) fromObject:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) afterGetAllIncidences: (NSDictionary*) json
{
    
    /*RMMapboxSource *tileSource = [[RMMapboxSource alloc] initWithMapID:@"examples.map-z2effxa8"];
    mapView = [[RMMapView alloc] initWithFrame:self.view.bounds andTilesource:tileSource];
    
    NSString *latstring;
    NSString *lonstring;
    CLLocationCoordinate2D punto;
    for (NSDictionary *markers in [json objectForKey:@"results"])
    {
        latstring = [[[markers objectForKey:@"geometry"] objectForKey:@"coordinates"] objectAtIndex:1];
        lonstring = [[[markers objectForKey:@"geometry"] objectForKey:@"coordinates"] objectAtIndex:0];
        
        punto.longitude = [lonstring doubleValue];
        punto.latitude = [latstring doubleValue];
        
        RMPointAnnotation *annotation = [[RMPointAnnotation alloc] initWithMapView:mapView
                                                                       coordinate:punto
                                                                         andTitle:@"Hello, world!"];
        [mapView addAnnotation:annotation];

        
    }
    
    [[LocationHelper getInstance]getCurrentLocation:@selector(afterGetCurrentLocation:) fromObject:self];*/
    
    
    dispatch_queue_t colaEnSerie = dispatch_queue_create("miColaEnSerie", NULL);
    NSUInteger aux = [[json objectForKey:@"results"] count];
    if(aux != 1){
        [[LocationHelper getInstance]getCurrentLocation:@selector(afterGetCurrentLocation:) fromObject:self];
    }
    for (NSDictionary *markers in [json objectForKey:@"results"])
    {
        dispatch_async(colaEnSerie, ^{
        
            NSString *latstring = [[[markers objectForKey:@"geometry"] objectForKey:@"coordinates"] objectAtIndex:1];
            NSString *lonstring = [[[markers objectForKey:@"geometry"] objectForKey:@"coordinates"] objectAtIndex:0];
        
            GMSMarker* marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake([latstring doubleValue], [lonstring doubleValue]);
            marker.title = [[markers objectForKey:@"properties"] objectForKey:@"titulo"];
            marker.snippet = [[markers objectForKey:@"properties"] objectForKey:@"nombre_municipio"];
            marker.icon = [GMSMarker markerImageWithColor:[UIColor colorWithRed:(247/255.0) green:(77/255.0) blue:0.0 alpha:1.0]];
            marker.appearAnimation = kGMSMarkerAnimationPop;
            marker.map = mapView;
            if(aux == 1){
                
                [mapView setCamera:([GMSCameraPosition cameraWithLatitude:[latstring doubleValue]
                                                               longitude:[lonstring doubleValue]
                                                                    zoom:9])];
            }
            
            //UILabel *aux = [[UILabel alloc]init];
            //CellIncidenceModel *incidencia = [[CellIncidenceModel alloc]init];
            
            //aux.text = marker.title;
            //[incidencia setTituloIncidencia:aux];
            //aux.text = marker.snippet;
            //[incidencia setMunicipioIncidencia:aux];
            
            
            
            /*[incidencia setTituloIncidencia:[[UILabel alloc] initWithFrame:CGRectMake(40, 70, 300, 100)]];
            incidencia.tituloIncidencia.text = @"dadwadawdadadawd";
            NSLog(incidencia.tituloIncidencia.text);
            [incidencia setMunicipioIncidencia:[[UILabel alloc] init]];
            incidencia.municipioIncidencia.text = marker.snippet;
            incidencia.estado = [[markers objectForKey:@"properties"] objectForKey:@"estado"];
            incidencia.idIncidencia  = [[markers objectForKey:@"properties"] objectForKey:@"id_incidencia"];*/

            
            marker.userData = markers;
        
        });
    }

}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



- (void) afterGetCurrentLocation: (CLLocation*) currentLocation
{
    /*mapView.centerCoordinate = currentLocation.coordinate;
    mapView.zoom = 9;
    [self.view addSubview:mapView];*/
    
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat: 1.0f] forKey:kCATransactionAnimationDuration];
    [mapView animateToCameraPosition:[GMSCameraPosition
                                                  cameraWithLatitude:currentLocation.coordinate.latitude
                                                  longitude:currentLocation.coordinate.longitude
                                                  zoom:11]];
    [CATransaction commit];
}

- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
    
   /* CGRect rect = infoWindow.frame;
    CGFloat width = infoWindow.frame.size.width;
    rect.size.width = 0;
    infoWindow.frame = rect;
    rect.size.width = width;*/
    
    
    labelFirstInfoWindow.text = marker.title;
    labelSecondInfoWindow.text = marker.snippet;
    
    CGRect frame = thumbnail.frame;
    if([[[marker.userData objectForKey:@"properties"] objectForKey:@"thumbnail"] isEqualToString:@""])
    {
        frame.size.height = 17;
        frame.size.width = 20;
        frame.origin.x = 12;
        frame.origin.y = 14;
        thumbnail.image = [UIImage imageNamed:@"POR_icon_bg_thumbnail.png"];
    }
    else
    {
        NSData *data = [NSData dataWithContentsOfURL : [NSURL URLWithString:[[marker.userData objectForKey:@"properties"] objectForKey:@"thumbnail"]]];
        frame.size.height = 50;
        frame.size.width = 50;
        frame.origin.x = 0;
        frame.origin.y = 0;
        thumbnail.image = [UIImage imageWithData: data];
        
        
    }
    
    thumbnail.frame = frame;
    
    
    
    /*[CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat: 2.0f] forKey:kCATransactionAnimationDuration];
        infoWindow.frame= rect;
    [CATransaction commit];*/
    
    
    
    return infoWindow;
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    if(self.navigate){
        IncidenceViewController *incidenceView = [self.storyboard instantiateViewControllerWithIdentifier:@"IncidenceViewController"];
        
        CellIncidenceModel *incidencia = [[CellIncidenceModel alloc]init];
        
        [incidencia setTituloIncidencia:[[UILabel alloc]init]];
        [incidencia.tituloIncidencia setText:marker.title];
        
        [incidencia setMunicipioIncidencia:[[UILabel alloc]init]];
        [incidencia.municipioIncidencia setText:marker.snippet];
        
        [incidencia setDescripcion:[[marker.userData objectForKey:@"properties"] objectForKey:@"descripcion"]];
        [incidencia setUser:[[marker.userData objectForKey:@"properties"] objectForKey:@"id_user"]];
        
        [incidencia setIdIncidencia:[[marker.userData objectForKey:@"properties"] objectForKey:@"id"]];
        [incidencia setEstado:[[marker.userData objectForKey:@"properties"] objectForKey:@"estado"]];
        
        
        [incidenceView setIncidencia:incidencia];
        
        
        [self.navigationController pushViewController:incidenceView animated:YES];
    }
}



@end
