//
//  iPosBankInfoData.h
//  iPosLib
//
//  Created by Chris on 5/29/15.
//  Copyright (c) 2015 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iPosBankInfoData : NSObject

@property(nonatomic, retain)NSString *strBankNO;
@property(nonatomic, retain)NSString *strBankCardLast4;
@property(nonatomic, retain)NSString *strBankCardNumber;
@property(nonatomic, retain)NSString *strBankName;
@property(nonatomic, retain)NSString *strBankAgreementCode;
@property(nonatomic, retain)NSString *strSignFlag;
@property(nonatomic, retain)NSString *strBankCardType;
@property(nonatomic, retain)NSString *strBankCardTypeName;
@property(nonatomic, retain)NSString *strSMSType;
@property(nonatomic, retain)NSString *strBindType;
@property(nonatomic, retain)NSString *strSignValidTime;
@property(nonatomic, retain)NSString *strPayLimit;
@property(nonatomic, retain)NSString *strBankMobileNo;// 银行预留手机号
@property(nonatomic, retain)NSString *strSIGNEXPDT;
@property(nonatomic, retain)NSString *strSIGNCVV;
@property(nonatomic, retain)NSString *strValidTimeEncrypted;//加密后的信用卡时间
@property(nonatomic, retain)NSString *strCVV2Encrypted;//加密后的信用卡CVV2
@property(nonatomic, assign)BOOL bIsDefautBankCard;
@property(nonatomic, assign)BOOL bIsBankCardBound;
@property(nonatomic, assign)BOOL bIsClientBankCard; // 用户自己是否已开通此快捷卡在手机客户端渠道的使用权限

@property(nonatomic, assign)BOOL bLargeMoneyRoute;// 大额快捷路由是否开通DKSUPFLG
@property(nonatomic, assign)BOOL bLargeMoneyNeedUpgrade;// 大额快捷是否已升级DKEFFFLG
@property(nonatomic, assign)BOOL bLargeMoneyNeedProvince; // 开户省是否需要CRDPROVTYP
@property(nonatomic, assign)BOOL bLargeMoneyNeedCity; // 开户市是否需要CRDCITYTYP
@property(nonatomic, assign)NSUInteger nLargeMoneyAmountLimit;// 大额风控金额DKAMTLMT

- (NSDictionary *)encodedIPosBankInfoData;

@end
