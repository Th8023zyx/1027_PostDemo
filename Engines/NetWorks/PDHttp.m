//
//  PDHttp.m
//  1027_PostDemo
//
//  Created by 中软mini002 on 15/10/27.
//
//

#import "PDHttp.h"

#define RET_CODE 0
#define SERVER_IP @"http://192.168.1.157/project"

@interface PDHttp ()

@property(nonatomic,strong)NSMutableURLRequest * request;

@end

@implementation PDHttp


+(instancetype)shareInstance {
    
    static PDHttp * instance = nil;
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken,^{
        
        instance = [[PDHttp alloc] init];
        
    });
    
    return instance;
    
}

-(id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(NSMutableURLRequest *)request {
    if (_request == nil) {
        _request = [[NSMutableURLRequest alloc] init];
    }
    return _request;
}

-(void)sendRequest :(NSString *)urlPath body:(NSString *) abody {
    NSURL * url = [[NSURL alloc] initWithString:[urlPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    // request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    
    
    
    NSData * data = [abody dataUsingEncoding:NSUTF8StringEncoding];
    
    [self.request setHTTPMethod:@"post"];
    
    [self.request setHTTPBody:data];
    
    [self.request setURL:url];
    
    [self.request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    
    [self.request setTimeoutInterval:10];
    
    [self.request addObserver:self forKeyPath:@"timeoutInterval" options:NSKeyValueObservingOptionNew context:nil];
    //[self.request setTimeoutInterval:10];
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:self.request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSLog(@"%@",data);
        if (data && data.length > 0 && connectionError == nil) {
            NSError * err = nil;
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
           
            
            if (dic && [dic count] > 0 && err == nil) {
                
                int ret = [[dic objectForKey:@"ret"] intValue];
                
                if (ret == RET_CODE) {
                    
                    if (_delegate && [_delegate respondsToSelector:@selector(PDHttpFinishedSuccessed:)]) {
                        [_delegate PDHttpFinishedSuccessed:dic];
                    }
                }else {
                    if (_delegate && [_delegate respondsToSelector:@selector(PDHttpFinishedFailed:)]) {
                        [_delegate PDHttpFinishedFailed:dic];
                    }
                }
            }else {
                if (_delegate && [_delegate respondsToSelector:@selector(PDHttpFinishedFailed:)]) {
                    [_delegate PDHttpFinishedFailed:dic];
                }

            }
            
        }
    }];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"timeoutInterval"]) {
        NSLog(@"123456");
    }
}

@end
