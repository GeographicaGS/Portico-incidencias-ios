//
//  DownloadManagerHelper.h
//  Pórtico incidencias
//
//  Created by Javier Aragón on 06/02/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AFHTTPRequestOperation.h"

@interface DownloadJsonHelper : NSObject

@property (strong, nonatomic) NSOperationQueue *operationQueue;
@property (nonatomic) BOOL allTasksPaused;

+ (id)getInstance;

-(void)downloadJson:(NSString *)url user:(NSString*)user password:(NSString*)password llamada:(NSString*)llamada funcion:(SEL)func fromObject:(id) object;
-(void)uploadJson:(NSString *)url parameters:(NSDictionary*)parameters user:(NSString*)user password:(NSString*)password funcion:(SEL)func fromObject:(id) object;
-(void)cancelDownload:(NSString *)url;
-(void)cleanDownloads;

-(void)pauseDownloads;
-(void)resumeDownloads;

+ (NSString *)md5:(NSString *) string;

@end
