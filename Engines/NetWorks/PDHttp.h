//
//  PDHttp.h
//  1027_PostDemo
//
//  Created by 中软mini002 on 15/10/27.
//
//

#import <Foundation/Foundation.h>

@protocol PDHttpDelegate <NSObject>

-(void)PDHttpFinishedSuccessed:(NSDictionary *)aDicData;

-(void)PDHttpFinishedFailed:(NSDictionary *)aDicData;

@end

@interface PDHttp : NSObject

@property(nonatomic,weak)id<PDHttpDelegate>delegate;

+(instancetype)shareInstance;

-(void)sendRequest :(NSString *)urlPath body:(NSString *) abody;

@end
