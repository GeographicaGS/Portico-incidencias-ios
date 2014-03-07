//
//  UserHelper.h
//  Pórtico incidencias
//
//  Created by Javier Aragón on 13/02/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//



@interface UserHelper : NSObject

+ (id)getInstance;
- (NSString*) getUsuario;
- (NSString*) getContrasenia;
- (void) setUsuario: (NSString*) usuario;
- (void) setContrasenia: (NSString*) contrasenia;


@end
