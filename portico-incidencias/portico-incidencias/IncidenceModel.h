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
+ (void) getIncidenciasPorUsuario:(SEL)func fromObject:(id) object offset: (NSString*) offset;
+ (void) getNumIncidenciasPorMunicipio:(SEL)func fromObject:(id) object offset: (NSString*) offset;

@end
