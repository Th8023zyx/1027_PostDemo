//
//  EngineInterface.m
//  1027_PostDemo
//
//  Created by 中软mini002 on 15/10/27.
//
//

#import "EngineInterface.h"
#import "PDHttp.h"
#import "NSString+Encrypt.h"

#define SERVER_IP @"http://192.168.1.159/project"

@interface EngineInterface ()<PDHttpDelegate>
@property(nonatomic,strong)PDHttp * pdHttp;
@end

@implementation EngineInterface
+(instancetype)shareInstance {
    
    static EngineInterface * instance = nil;
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken,^{
        
        instance = [[EngineInterface alloc] init];
        
    });
    
    return instance;
    
}

-(PDHttp *)pdHttp {
    if (_pdHttp == nil) {
        _pdHttp = [[PDHttp alloc] init];
        _pdHttp.delegate = self;
    }
    return _pdHttp;
}

#pragma mark-PDHttpDelegate

-(void)PDHttpFinishedSuccessed:(NSDictionary *)aDicData {
    NSLog(@"Successed=%@",aDicData);
}

-(void)PDHttpFinishedFailed:(NSDictionary *)aDicData {
    NSLog(@"Failed=%@",aDicData);
}


-(void)login:(NSString *) userName pwd:(NSString *) userPwd {
    
    NSString * url = [NSString stringWithFormat:@"%@/login.php", SERVER_IP];
    NSString * body = [NSString stringWithFormat:@"username=%@&userpwd=%@",userName,[NSString md5Encrytion:userPwd]];
    [self.pdHttp sendRequest:url body:body];
}


-(void)regist:(NSString *) userName pwd:(NSString *) userPwd {
    NSString * url = [NSString stringWithFormat:@"%@/register.php",SERVER_IP ];
    NSString * body = [NSString stringWithFormat:@"username=%@&userpwd=%@",userName,[NSString md5Encrytion:userPwd]];
    [self.pdHttp sendRequest:url body:body];

}

@end
