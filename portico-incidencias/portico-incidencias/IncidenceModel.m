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

+ (void) getIncidenciasPorFechaPorMunicipio:(SEL)func fromObject:(id) object offset: (NSString*) offset search: (NSString*) search municipio:(NSNumber*)municipio
{
    [[DownloadJsonHelper getInstance] cleanDownloads];
    NSString *url =  [NSMutableString stringWithFormat:@"%@%@%@%@%@%@%@", basePath, @"incidenciasByMunicipio/" , municipio, @"/" ,[NSString stringWithFormat:@"%d", LIMIT] , @"/" , offset];
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

+ (void) getIncidenciasByDistByTown:(SEL)func fromObject:(id) object offset: (NSString*) offset latitud:(float) latitud longitud:(float) longitud search: (NSString*) search municipio:(NSNumber*)municipio
{
    [[DownloadJsonHelper getInstance] cleanDownloads];
    NSString *url =  [NSMutableString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@", basePath, @"incidenciasByDistByTown/", municipio, @"/" , [NSString stringWithFormat:@"%d", LIMIT] , @"/" , offset, @"/", [NSString stringWithFormat:@"%f", latitud], @"/", [NSString stringWithFormat:@"%f", longitud]];
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

+ (void) getIncidenciasPorUsuario:(SEL)func fromObject:(id) object offset: (NSString*) offset search: (NSString*) search estado: (int) estado
{
    [[DownloadJsonHelper getInstance] cleanDownloads];
    NSString *url =  [NSMutableString stringWithFormat:@"%@%@%@%@%d%@%@%@%@", basePath, @"incidencias_by_user/" , [[UserHelper getInstance] getUsuario] , @"/", estado, @"/", [NSString stringWithFormat:@"%d", LIMIT] , @"/" , offset];
    if([search length] != 0)
    {
        url = [url stringByAppendingString:[NSMutableString stringWithFormat:@"%@%@", @"/", search]];
    }
    [[DownloadJsonHelper getInstance]downloadJson: url user:[[UserHelper getInstance]getUsuario] password:[[UserHelper getInstance]getContrasenia] llamada:@"GET" funcion:func fromObject:object];
}

+ (void) getIncidenciasByDistByUser:(SEL)func fromObject:(id) object offset: (NSString*) offset latitud:(float) latitud longitud:(float) longitud search: (NSString*) search estado: (int) estado
{
    [[DownloadJsonHelper getInstance] cleanDownloads];
    NSString *url =  [NSMutableString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%d", basePath, @"incidenciasByDistByUser/" , [NSString stringWithFormat:@"%d", LIMIT] , @"/" , offset, @"/", [NSString stringWithFormat:@"%f", latitud], @"/", [NSString stringWithFormat:@"%f", longitud], @"/", [[UserHelper getInstance] getUsuario],@"/",estado];
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

+ (void) getIncidenceImages:(SEL)func fromObject:(id) object idIncidencia: (NSNumber*) idIncidencia
{
   // [[DownloadJsonHelper getInstance] cleanDownloads];
    NSString *url =  [NSMutableString stringWithFormat:@"%@%@%@", basePath, @"incidence_images/", idIncidencia];
    
    [[DownloadJsonHelper getInstance]downloadJson: url user:[[UserHelper getInstance]getUsuario] password:[[UserHelper getInstance]getContrasenia] llamada:@"GET" funcion:func fromObject:object];
}

+(void) getThumbnail:(SEL)func fromObject:(id) object idIncidencia: (NSNumber*) idIncidencia
{
    [[DownloadJsonHelper getInstance] cleanDownloads];
    NSString *url =  [NSMutableString stringWithFormat:@"%@%@%@", basePath, @"thumbnail/", idIncidencia];
    
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

+ (void) addImages:(SEL)func fromObject:(id) object parameters:(NSMutableDictionary*) parameters images:(NSMutableArray *) images 
{
    UIImage *image;
    NSString *url =  [NSMutableString stringWithFormat:@"%@%@", basePath, @"addIncidenceImage"];
    CGFloat oldWidth;
    CGFloat oldHeight;
    CGFloat scaleFactor;
    CGFloat newHeight;
    CGFloat newWidth;
    CGSize newSize;
    bool lastImage = false;
    
    for (int i=0; i<[images count]; i++) {
        
        image = [images objectAtIndex:i];
        if(image.size.width > 2500 || image.size.height > 2500){
            oldWidth = image.size.width;
            oldHeight = image.size.height;
            scaleFactor = (oldWidth > oldHeight) ? 2500 / oldWidth : 2500 / oldHeight;
            newHeight = oldHeight * scaleFactor;
            newWidth = oldWidth * scaleFactor;
            newSize = CGSizeMake(newWidth, newHeight);
            
            UIGraphicsBeginImageContext(newSize);
            [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        
        NSString *strEncoded = [UIImageJPEGRepresentation(image, 0.1f) base64EncodedStringWithOptions:(kNilOptions)];
        strEncoded = [strEncoded stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        [parameters setObject:strEncoded forKey:@"image"];

        if(i == ([images count] -1))
        {
            lastImage = true;
        }
        
        [[DownloadJsonHelper getInstance]uploadImage:url parameters:parameters user:[[UserHelper getInstance]getUsuario] password:[[UserHelper getInstance]getContrasenia] funcion:func fromObject:object lastImage:lastImage];
    }
}


@end
