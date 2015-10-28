//
//  EngineInterface.h
//  1027_PostDemo
//
//  Created by 中软mini002 on 15/10/27.
//
//

#import <Foundation/Foundation.h>

@interface EngineInterface : NSObject
+(instancetype)shareInstance;

-(void)login:(NSString *) userName pwd:(NSString *) userPwd;
-(void)regist:(NSString *) userName pwd:(NSString *) userPwd;

@end
