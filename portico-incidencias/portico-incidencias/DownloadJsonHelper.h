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

+ (id)getInstance;

-(void)downloadJson:(NSString *)url funcion:(SEL)func fromObject:(id) object;
/*-(void)cancelDownload:(MDDownload *)download;
-(void)cleanDownloads;

-(void)pauseDownloads;
-(void)resumeDownloads;*/

@end
