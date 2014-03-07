//
//  TimerHelper.h
//  Pórtico incidencias
//
//  Created by Javier Aragón on 03/03/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimerHelper : NSObject

+ (id)getInstance;

- (void) start: (double) interval funcion:(SEL)func fromObject:(id) object;

@end
