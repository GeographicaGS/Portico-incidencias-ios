//
//  RequestHelper.m
//  Pórtico incidencias
//
//  Created by Javier Aragón on 05/02/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import "UserModel.h"
#import "Header.h"





@implementation UserModel

+ (BOOL) initSesion:(NSString*)user password:(NSString*)password
{
    [[DownloadJsonHelper getInstance]downloadJson: [basePath stringByAppendingString:@"user/login"] funcion:@selector(afterInitSesion:) fromObject:self];
    
    return TRUE;
}

+(void) afterInitSesion: (NSDictionary*) json
{
    NSLog(@"Entro en prueba");
}

@end
