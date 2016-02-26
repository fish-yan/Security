# Security
常见加密形式
- 突然想到加密的问题, 就搜罗了一下iOS中常见的加密方法, 比较简单的加密方式主要就这几种了AES加密, DES加密, MD5加密,SHA1加密,  BASE64加密

- ####AES加密
```Objective-C
//AES加密
#import "AESCrypt.h"
```

```Objective-C
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
```

- ####DES加密
DES加密基本与AES是一样的,就不说了.

- #### MD5加密 , SHA1加密
把这两个放一块,也是因为这两个基本上写法都一样
```Objective-C
//MD5加密  SHA1加密
#import <CommonCrypto/CommonCrypto.h>
```

```Objective-C
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

```

- ####BASE64加密
```Objective-C
//BASE64加密
#import "GTMBase64.h"
```

```Objective-C
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
```
