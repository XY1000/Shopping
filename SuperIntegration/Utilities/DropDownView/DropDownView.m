//
//  DropDownView.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/3/8.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "DropDownView.h"

@interface DropDownView()

@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) UIButton *btnSender;
@property(nonatomic, retain) NSArray *list;

@end

@implementation DropDownView

- (void)showDropDown:(UIButton *)Button height:(CGFloat)Height array:(NSArray *)Array {
    self.btnSender = Button;
    CGRect btn = Button.frame;
    
    self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height+20, btn.size.width, 0);
    self.list = [NSArray arrayWithArray:Array];
    self.layer.masksToBounds = NO;
    self.layer.cornerRadius = 8;
    self.layer.shadowOffset = CGSizeMake(-5, 5);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.5;
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, btn.size.width, 0)];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.layer.cornerRadius = 5;
    self.table.backgroundColor = [UIColor colorWithRed:0.239 green:0.239 blue:0.239 alpha:1];
//    self.table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    self.table.separatorColor = [UIColor grayColor];
    self.table.separatorInset = UIEdgeInsetsMake(0, self.table.frame.size.width, 0, self.table.frame.size.width);
    self.table.backgroundColor = [UIColor whiteColor];
    self.table.scrollEnabled = NO;
    
    [self.table registerClass:[DropDownTableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height+20, btn.size.width, Height);
    self.table.frame = CGRectMake(0, 0, btn.size.width, Height);
    [UIView commitAnimations];
    
    [self addSubview:self.table];
}

- (void)hideDropDown:(UIButton *)Button {
    CGRect btn = Button.frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height+20, btn.size.width, 0);
    self.table.frame = CGRectMake(0, 0, btn.size.width, 0);
    [UIView commitAnimations];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    DropDownTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell cellWithTxt:self.list[indexPath.row]];
    
    UIView * v = [[UIView alloc] init];
    v.backgroundColor = [UIColor grayColor];
    cell.selectedBackgroundView = v;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideDropDown:self.btnSender];
    DropDownTableViewCell *c = (DropDownTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    self.block_DidSelect(c.label_Title.text);
}


@end


@interface DropDownTableViewCell()

@end

@implementation DropDownTableViewCell

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)cellWithTxt:(NSString *)txt {
    self.label_Title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.label_Title.textColor = [UIColor blackColor];
    self.label_Title.text = txt;
    self.label_Title.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.label_Title];
}

@end
