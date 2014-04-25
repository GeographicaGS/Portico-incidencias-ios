//
//  TableHelperIncidencias.h
//  Pórtico incidencias
//
//  Created by Javier Aragón on 14/02/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import "TableHelper.h"
#import <CoreLocation/CoreLocation.h>

@interface TableHelperIncidencias : TableHelper

@property int tipoListado;
@property NSNumber *idMunicipio;
@property CLLocation* currentLocation;

@end
