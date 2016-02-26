//
//  ViewController.m
//  Security
//
//  Created by 薛焱 on 16/2/26.
//  Copyright © 2016年 薛焱. All rights reserved.
//

#import "ViewController.h"
//AES加密
#import "AESCrypt.h"
#define kCryptStr @"与后台约定的加密所需加密内容的密码"

//MD5加密  SHA1加密哦
#import <CommonCrypto/CommonCrypto.h>

//BASE64加密
#import "GTMBase64.h"

@interface ViewController (){
    NSString *encryptData;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self encrypt];
    [self decrypt];
    NSLog(@"加密后:%@", [ViewController MD5HexDigest:@"所需要加密的内容"]);
    NSLog(@"加密后:%@", [ViewController SHA1Digest:@"所需要加密的内容"]);
    NSLog(@"加密%@", [ViewController encodeBase64String:@"所需要加密的内容"]);
    NSLog(@"解密后:%@", [ViewController decodeBase64String:[ViewController encodeBase64String:@"所需要加密的内容"]]);
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - AES加密
//加密
- (void)encrypt{
    //需要加密的内容
    NSString *password = @"所需要加密的内容";
    encryptData = [AESCrypt encrypt:password password:kCryptStr];
    NSLog(@"加密后:%@",encryptData);
}

//解密
- (void)decrypt{
    NSString *descryptData = [AESCrypt decrypt:encryptData password:kCryptStr];
    NSLog(@"解密后:%@",descryptData);
}
#pragma mark - DES加密, 跟AES加密是一样的,就不写了

#pragma mark - MD5加密
/**
 *  MD5加密
 *
 *  @param input 加密前的字符串
 *
 *  @return 加密后的字符串
 */
+ (NSString *)MD5HexDigest:(NSString *)input{
    const char *cstr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cstr, (CC_LONG)strlen(cstr), digest);
    NSMutableString *output = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02X", digest[i]];
    }
    return [output lowercaseString];
}

#pragma mark - SHA1加密
/**
 *  SHA1加密
 *
 *  @param input 加密前的字符串
 *
 *  @return 加密后的字符串
 */
+ (NSString *)SHA1Digest:(NSString *)input{
    const char *cstr = [input UTF8String];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(cstr, (CC_LONG)strlen(cstr), digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH *2];
    for (int i = 0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",digest[i]];
    }
    return output;
}
#pragma mark - BASE64加密
/**
 *  BASE64加密
 *
 *  @param input 加密前的字符串
 *
 *  @return 加密后的字符串
 */
+ (NSString*)encodeBase64String:(NSString * )input {
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    data = [GTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}
//BASE64解密
+ (NSString *)decodeBase64String:(NSString *)input{
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 decodeString:input];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
