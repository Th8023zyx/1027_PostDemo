//
//  NSString+Encrypt.m
//  1027_PostDemo
//
//  Created by 中软mini002 on 15/10/28.
//
//

#import "NSString+Encrypt.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Encrypt)
+(NSString*) md5Encrytion:(NSString*) str {
    const char *cStr = [str UTF8String];
    //  无符号字符数组 16位
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (uint32_t)strlen(cStr), digest);
    
    NSMutableString *encryptionString = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH *2];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        //  将转换后的字符转换成16进制, 02表示不足两位前面补0,  例如 "a" -> "0a",  "3" -> "03"
        [encryptionString appendFormat:@"%02x",digest[i]];
    }
    
    return encryptionString;
    
}
@end
