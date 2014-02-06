//
//  DownloadManagerHelper.m
//  Pórtico incidencias
//
//  Created by Javier Aragón on 06/02/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import "DownloadJsonHelper.h"

@implementation DownloadJsonHelper

+ (id)getInstance
{
    
    static DownloadJsonHelper *instance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        instance = [[DownloadJsonHelper alloc] init];
    });
    
    return instance;
}


-(id)init
{
    if (self = [super init])
    {
        _operationQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}


-(void)downloadJson:(NSString *)url funcion:(SEL)func fromObject:(id) object
{
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://10.30.102.56:5000/user/login" parameters:nil constructingBodyWithBlock:nil error:nil];
    
    NSURLCredential *credential = [NSURLCredential credentialWithUser:@"hector.garcia@geographica.gs" password:@"eac9e8dd8575f4c7831f1f6a72607126" persistence:NSURLCredentialPersistenceNone];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCredential:credential];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:operation.responseData
                              options:0
                              error:nil];
        
        [object performSelector:func withObject:json];
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [self.operationQueue addOperation:operation];
}

@end
