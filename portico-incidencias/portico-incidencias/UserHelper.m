//
//  UserHelper.m
//  Pórtico incidencias
//
//  Created by Javier Aragón on 13/02/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import "UserHelper.h"

NSString *user = @"";
NSString *password = @"";

@implementation UserHelper

+ (id)getInstance
{
    
    static UserHelper *instance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        instance = [[UserHelper alloc] init];
    });
    
    return instance;
}


-(id)init
{
    if (self = [super init])
    {
       
    }
    return self;
}

- (NSString*) getUsuario
{
    return user;
}

- (NSString*) getContrasenia
{
    return password;
}

- (void) setUsuario: (NSString*) usuario
{
    user = usuario;
}

- (void) setContrasenia: (NSString*) contrasenia
{
    password = contrasenia;
}

@end
