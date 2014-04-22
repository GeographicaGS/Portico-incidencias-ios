//
//  IncidenceModel.m
//  Pórtico incidencias
//
//  Created by Javier Aragón on 13/02/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import "IncidenceModel.h"
#import "Header.h"

@implementation IncidenceModel

+ (void) getIncidenciasPorFecha:(SEL)func fromObject:(id) object offset: (NSString*) offset search: (NSString*) search
{
    [[DownloadJsonHelper getInstance] cleanDownloads];
    NSString *url =  [NSMutableString stringWithFormat:@"%@%@%@%@%@", basePath, @"incidencias/" , [NSString stringWithFormat:@"%d", LIMIT] , @"/" , offset];
    if([search length] != 0)
    {
        url = [url stringByAppendingString:[NSMutableString stringWithFormat:@"%@%@", @"/", search]];
    }
    [[DownloadJsonHelper getInstance]downloadJson: url user:[[UserHelper getInstance]getUsuario] password:[[UserHelper getInstance]getContrasenia] llamada:@"GET" funcion:func fromObject:object];
}

+ (void) getIncidenciasByDist:(SEL)func fromObject:(id) object offset: (NSString*) offset latitud:(float) latitud longitud:(float) longitud search: (NSString*) search
{
    [[DownloadJsonHelper getInstance] cleanDownloads];
    NSString *url =  [NSMutableString stringWithFormat:@"%@%@%@%@%@%@%@%@%@", basePath, @"incidenciasByDist/" , [NSString stringWithFormat:@"%d", LIMIT] , @"/" , offset, @"/", [NSString stringWithFormat:@"%f", latitud], @"/", [NSString stringWithFormat:@"%f", longitud]];
    if([search length] != 0)
    {
        url = [url stringByAppendingString:[NSMutableString stringWithFormat:@"%@%@", @"/", search]];
    }
    [[DownloadJsonHelper getInstance]downloadJson: url user:[[UserHelper getInstance]getUsuario] password:[[UserHelper getInstance]getContrasenia] llamada:@"GET" funcion:func fromObject:object];
}

+ (void) getGeoJsonIncidenciasByDist:(SEL)func fromObject:(id) object
{
    [[DownloadJsonHelper getInstance] cleanDownloads];
    NSString *url =  [NSMutableString stringWithFormat:@"%@%@", basePath, @"geoJsonIncidenciasByDist"];
    
    [[DownloadJsonHelper getInstance]downloadJson: url user:[[UserHelper getInstance]getUsuario] password:[[UserHelper getInstance]getContrasenia] llamada:@"GET" funcion:func fromObject:object];
}

+ (void) getIncidenciasPorUsuario:(SEL)func fromObject:(id) object offset: (NSString*) offset search: (NSString*) search
{
    [[DownloadJsonHelper getInstance] cleanDownloads];
    NSString *url =  [NSMutableString stringWithFormat:@"%@%@%@%@%@%@%@", basePath, @"incidencias_by_user/" , [[UserHelper getInstance] getUsuario] , @"/", [NSString stringWithFormat:@"%d", LIMIT] , @"/" , offset];
    if([search length] != 0)
    {
        url = [url stringByAppendingString:[NSMutableString stringWithFormat:@"%@%@", @"/", search]];
    }
    [[DownloadJsonHelper getInstance]downloadJson: url user:[[UserHelper getInstance]getUsuario] password:[[UserHelper getInstance]getContrasenia] llamada:@"GET" funcion:func fromObject:object];
}

+ (void) getIncidenciasByDistByUser:(SEL)func fromObject:(id) object offset: (NSString*) offset latitud:(float) latitud longitud:(float) longitud search: (NSString*) search
{
    [[DownloadJsonHelper getInstance] cleanDownloads];
    NSString *url =  [NSMutableString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@", basePath, @"incidenciasByDistByUser/" , [NSString stringWithFormat:@"%d", LIMIT] , @"/" , offset, @"/", [NSString stringWithFormat:@"%f", latitud], @"/", [NSString stringWithFormat:@"%f", longitud], @"/", [[UserHelper getInstance] getUsuario]];
    if([search length] != 0)
    {
        url = [url stringByAppendingString:[NSMutableString stringWithFormat:@"%@%@", @"/", search]];
    }
    [[DownloadJsonHelper getInstance]downloadJson: url user:[[UserHelper getInstance]getUsuario] password:[[UserHelper getInstance]getContrasenia] llamada:@"GET" funcion:func fromObject:object];
}

+ (void) getNumIncidenciasPorMunicipio:(SEL)func fromObject:(id) object offset: (NSString*) offset search: (NSString*) search
{
    [[DownloadJsonHelper getInstance] cleanDownloads];
    NSString *url =  [NSMutableString stringWithFormat:@"%@%@", basePath, @"num_incidencias_by_town"];
    if([search length] != 0)
    {
        url = [url stringByAppendingString:[NSMutableString stringWithFormat:@"%@%@", @"/", search]];
    }
    [[DownloadJsonHelper getInstance]downloadJson: url user:[[UserHelper getInstance]getUsuario] password:[[UserHelper getInstance]getContrasenia] llamada:@"GET" funcion:func fromObject:object];
}

+ (void) getGeoJsonIncidencia:(SEL)func fromObject:(id) object idIncidencia: (NSNumber*) idIncidencia{
    [[DownloadJsonHelper getInstance] cleanDownloads];
    NSString *url =  [NSMutableString stringWithFormat:@"%@%@%@", basePath, @"geoJsonIncidencia/", idIncidencia];
    
    [[DownloadJsonHelper getInstance]downloadJson: url user:[[UserHelper getInstance]getUsuario] password:[[UserHelper getInstance]getContrasenia] llamada:@"GET" funcion:func fromObject:object];
}

+ (void) getIncidenceComents:(SEL)func fromObject:(id) object idIncidencia: (NSNumber*) idIncidencia{
    [[DownloadJsonHelper getInstance] cleanDownloads];
    NSString *url =  [NSMutableString stringWithFormat:@"%@%@%@", basePath, @"incidence_coments/", idIncidencia];
    
    [[DownloadJsonHelper getInstance]downloadJson: url user:[[UserHelper getInstance]getUsuario] password:[[UserHelper getInstance]getContrasenia] llamada:@"GET" funcion:func fromObject:object];
}

+ (void) addComment:(SEL)func fromObject:(id) object comment: (NSString*) comment idIncidencia: (NSNumber*) idIncidencia
{
    
    NSString *url =  [NSMutableString stringWithFormat:@"%@%@", basePath, @"addComment"];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:comment, @"comment", [[UserHelper getInstance]getUsuario], @"user", idIncidencia, @"idIncidencia", nil];
    
    [[DownloadJsonHelper getInstance]uploadJson:url parameters:parameters user:[[UserHelper getInstance]getUsuario] password:[[UserHelper getInstance]getContrasenia] funcion:func fromObject:object];
}

+ (void) createIncidence:(SEL)func fromObject:(id) object parameters:(NSDictionary*) parameters
{
    
    NSString *url =  [NSMutableString stringWithFormat:@"%@%@", basePath, @"createIncidence"];
    
    [[DownloadJsonHelper getInstance]uploadJson:url parameters:parameters user:[[UserHelper getInstance]getUsuario] password:[[UserHelper getInstance]getContrasenia] funcion:func fromObject:object];
}




@end
