//
//  RequestHelper.h
//  Pórtico incidencias
//
//  Created by Javier Aragón on 05/02/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

+ (BOOL)initSesion:(NSString*)user password:(NSString*)password;

+(void) afterInitSesion: (NSDictionary*) json;


@end
