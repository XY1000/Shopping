//
//  AddressTableViewCell.m
//  SuperIntegration
//
//  Created by tmp on 16/1/28.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "AddressTableViewCell.h"

@interface AddressTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *deletBtn;

@end
@implementation AddressTableViewCell

- (void)setListModel:(AddresslistModel *)listModel{
    
    _listModel = listModel;
    
    _name.text = listModel.contact;
    

    if (!STR_IS_NIL(listModel.telephone)) {
        self.phone.text = [NSString stringWithFormat:@"%@", [listModel.telephone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"]];
    } else {
        self.phone.text = [NSString stringWithFormat:@"%@", [listModel.phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"]];;
    }
   
    _address.text = [NSString stringWithFormat:@"%@ %@",listModel.fullAddress,listModel.addressDetail];
    _defaultBtn.selected = listModel.isDefault;
    
    
    _deletBtn.tag = self.tag;
    
}





@end
