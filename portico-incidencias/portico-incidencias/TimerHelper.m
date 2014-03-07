//
//  TimerHelper.m
//  Pórtico incidencias
//
//  Created by Javier Aragón on 03/03/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import "TimerHelper.h"

NSTimer *timer;
BOOL contando = NO;
int contadorSeg = 0;
SEL funcion = nil;
id clase = nil;

@implementation TimerHelper

+ (id)getInstance
{
    
    static TimerHelper *instance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        instance = [[TimerHelper alloc] init];
    });
    
    return instance;
}

- (void) start: (double) interval funcion:(SEL)func fromObject:(id) object
{
   
    if(contando == NO)
    {
        contando = YES;
        contadorSeg = 0;
        funcion = func;
        clase = object;
        timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(contar) userInfo:nil repeats:YES];
    }
    else
    {
        contadorSeg = 0;
    }
    
}


-(void) contar
{
    contadorSeg ++;
    if(contadorSeg >= 1)
    {
        [clase performSelector:funcion];
        [timer invalidate];
        timer =  nil;
        contando = NO;
        funcion = nil;
        clase = nil;
    }
}

@end
