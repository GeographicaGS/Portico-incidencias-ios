//
//  IncidenceModel.h
//  Pórtico incidencias
//
//  Created by Javier Aragón on 13/02/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IncidenceModel : NSObject

+ (void) getIncidenciasPorFecha:(SEL)func fromObject:(id) object offset: (NSString*) offset search: (NSString*) search;
+ (void) getIncidenciasByDist:(SEL)func fromObject:(id) object offset: (NSString*) offset latitud:(float) latitud longitud:(float) longitud search: (NSString*) search;
+ (void) getIncidenciasPorUsuario:(SEL)func fromObject:(id) object offset: (NSString*) offset search: (NSString*) search;
+ (void) getIncidenciasByDistByUser:(SEL)func fromObject:(id) object offset: (NSString*) offset latitud:(float) latitud longitud:(float) longitud search: (NSString*) search;
+ (void) getNumIncidenciasPorMunicipio:(SEL)func fromObject:(id) object offset: (NSString*) offset search: (NSString*) search;
+ (void) getGeoJsonIncidenciasByDist:(SEL)func fromObject:(id) object;
+ (void) getGeoJsonIncidencia:(SEL)func fromObject:(id) object idIncidencia: (NSNumber*) idIncidencia;
+ (void) getIncidenceComents:(SEL)func fromObject:(id) object idIncidencia: (NSNumber*) idIncidencia;

+ (void) addComment:(SEL)func fromObject:(id) object comment: (NSString*) comment idIncidencia: (NSNumber*) idIncidencia;
+ (void) createIncidence:(SEL)func fromObject:(id) object parameters:(NSDictionary*) parameters;

@end
