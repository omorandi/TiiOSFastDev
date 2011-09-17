/**
 * Appcelerator Titanium Mobile
 * This is generated code. Do not modify. Your changes will be lost.
 */
#import <Foundation/Foundation.h>
#import "ApplicationRouting.h"
#import "ASIHTTPRequest.h"
#import "ServerAddr.h"
#import "ServerPort.h"

@implementation ApplicationRouting

+ (NSData*) resolveAppAsset:(NSString*)path;
{
    NSString *ServerAddr = SERVER_ADDRESS;
    NSString *ServerPort = SERVER_PORT;
    NSString *path_url = [NSString stringWithFormat:@"http://%@:%@/%@",ServerAddr, ServerPort, path];
    
    NSURL *url = [NSURL URLWithString:path_url];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    if ([request responseStatusCode] != 200)
        return nil;
    
    NSError *error = [request error];
    if (error) 
        return nil;
    
    return [request responseData];
    
}



@end
