//
//  DownloadManagerHelper.m
//  Pórtico incidencias
//
//  Created by Javier Aragón on 06/02/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
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
        _allTasksPaused = NO;
    }
    return self;
}


-(void)downloadJson:(NSString *)url user:(NSString*)user password:(NSString*)password llamada:(NSString*)llamada funcion:(SEL)func fromObject:(id) object
{
    // Compruebo que no se este descargando ya ese fichero
    BOOL downloading = NO;
    NSURLRequest *request;
    for (AFHTTPRequestOperation *op in self.operationQueue.operations) {
        if ([url isEqualToString:op.request.URL.description]) {
            downloading = YES;
            break;
        }
    }
    
    if(!downloading)
    {
        if([llamada isEqualToString:@"POST"])
        {
            request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:llamada URLString:url parameters:nil constructingBodyWithBlock:nil error:nil];
        }
        else
        {
            request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        }
        
        
        NSURLCredential *credential = [NSURLCredential credentialWithUser:user password: [DownloadJsonHelper md5:password] persistence:NSURLCredentialPersistenceNone];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [operation setCredential:credential];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary* json = [NSJSONSerialization
                                  JSONObjectWithData:operation.responseData
                                  options:0
                                  error:nil];
            
            [object performSelector:func withObject:json];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSDictionary *json = [[NSDictionary alloc] initWithObjectsAndKeys:error, @"error", nil];
            [object performSelector:func withObject:json];
        }];
        
        [self.operationQueue addOperation:operation];
    }
    
}

-(void)uploadJson:(NSString *)url parameters:(NSDictionary*)parameters user:(NSString*)user password:(NSString*)password funcion:(SEL)func fromObject:(id) object
{
    /*NSURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:parameters constructingBodyWithBlock:^(id <AFMultipartFormData>formData) {
    }];*/

    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:parameters error:nil];
                             
    NSURLCredential *credential = [NSURLCredential credentialWithUser:user password: [DownloadJsonHelper md5:password] persistence:NSURLCredentialPersistenceNone];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCredential:credential];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:operation.responseData
                              options:0
                              error:nil];
        
        [object performSelector:func withObject:json];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSDictionary *json = [[NSDictionary alloc] initWithObjectsAndKeys:error, @"error", nil];
        [object performSelector:func withObject:json];
    }];
    
    [self.operationQueue addOperation:operation];
  
    
}

-(void)cancelDownload:(NSString *)url
{
    for (AFHTTPRequestOperation *op in self.operationQueue.operations) {
        if ([url isEqualToString:op.request.URL.description]) {
            NSLog(@"Localizada tarea a borrar");
            // Cancelamos la operation
            [op cancel];
        }
        
    }
}

-(void)cleanDownloads {
    
    for (AFHTTPRequestOperation *op in self.operationQueue.operations)
    {
        [op cancel];
    }
}

-(void)pauseDownloads {
    
    if (!self.allTasksPaused)
    {
        for (AFHTTPRequestOperation *op in self.operationQueue.operations)
        {
            [op pause];
        }
        self.allTasksPaused = !self.allTasksPaused;
    }
}

-(void)resumeDownloads
{
    if (self.allTasksPaused)
    {
        for (AFHTTPRequestOperation *op in self.operationQueue.operations)
        {
            [op resume];
        }
        self.allTasksPaused = !self.allTasksPaused;
    }
}

+ (NSString *)md5:(NSString *) string
{
    const char *cStr = [string UTF8String];
    unsigned char digest[16];
    
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *resultString = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [resultString appendFormat:@"%02x", digest[i]];
    return  resultString;
}

@end
