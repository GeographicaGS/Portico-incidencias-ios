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

+ (BOOL) initSesion:(NSString*)user password:(NSString*)password funcion:(SEL)func fromObject:(id) object
{
    [[DownloadJsonHelper getInstance]downloadJson:[basePath stringByAppendingString:@"user/login"] user:user password:password llamada:@"POST" funcion:func fromObject:object];
    
    return TRUE;
}

@end
