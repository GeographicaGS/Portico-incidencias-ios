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
+ (void) getIncidenciasPorFechaPorMunicipio:(SEL)func fromObject:(id) object offset: (NSString*) offset search: (NSString*) search municipio:(NSNumber*)municipio;
+ (void) getIncidenciasByDist:(SEL)func fromObject:(id) object offset: (NSString*) offset latitud:(float) latitud longitud:(float) longitud search: (NSString*) search;
+ (void) getIncidenciasByDistByTown:(SEL)func fromObject:(id) object offset: (NSString*) offset latitud:(float) latitud longitud:(float) longitud search: (NSString*) search municipio:(NSNumber*)municipio;
+ (void) getIncidenciasPorUsuario:(SEL)func fromObject:(id) object offset: (NSString*) offset search: (NSString*) search estado: (int) estado;
+ (void) getIncidenciasByDistByUser:(SEL)func fromObject:(id) object offset: (NSString*) offset latitud:(float) latitud longitud:(float) longitud search: (NSString*) search estado: (int) estado;
+ (void) getNumIncidenciasPorMunicipio:(SEL)func fromObject:(id) object offset: (NSString*) offset search: (NSString*) search;
+ (void) getGeoJsonIncidenciasByDist:(SEL)func fromObject:(id) object;
+ (void) getGeoJsonIncidencia:(SEL)func fromObject:(id) object idIncidencia: (NSNumber*) idIncidencia;
+ (void) getIncidenceComents:(SEL)func fromObject:(id) object idIncidencia: (NSNumber*) idIncidencia;
+ (void) getIncidenceImages:(SEL)func fromObject:(id) object idIncidencia: (NSNumber*) idIncidencia;
+ (void) getThumbnail:(SEL)func fromObject:(id) object idIncidencia: (NSNumber*) idIncidencia;

+ (void) addComment:(SEL)func fromObject:(id) object comment: (NSString*) comment idIncidencia: (NSNumber*) idIncidencia;
+ (void) createIncidence:(SEL)func fromObject:(id) object parameters:(NSDictionary*) parameters;
+ (void) addImages:(SEL)func fromObject:(id) object parameters:(NSDictionary*) parameters images:(NSMutableArray *) images;

+ (void) getTypologies:(SEL)func fromObject:(id) object;


+ (NSString*) createSearch: (NSString*) search;

@end
