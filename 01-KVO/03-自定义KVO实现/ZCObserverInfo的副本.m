//
//  ComplaintCommentFrame.m
//  xfb
//
//  Created by XFB on 2019/10/8.
//  Copyright © 2019 XFB. All rights reserved.
//

#import "ComplaintCommentFrame.h"
#import "FirstCommentModel.h"
#import "NSString+Size.h"

@implementation ComplaintCommentFrame

- (instancetype)initWithFirstComment:(ComplaintFirstComment *)firstCommentM {
    self = [super init];
    if (self) {
        self.firstCommentM = firstCommentM;
        [self setupLayouts];
    }
    return self;
}

- (void)setupLayouts {
    
    self.margeX = 15;
    self.margeY = 15;
    
    CGFloat topLineX = 15;
    CGFloat topLineY = 0;
    CGFloat topLineW = ScreenWidth-30;
    CGFloat topLineH = 0.5;
    _topLineViewF = (CGRect){topLineX, topLineY, topLineW, topLineH};
    
    // 1.头像
    CGFloat avatarX = self.margeX;
    CGFloat avatarY = self.margeY;
    CGFloat avatarW = 30;
    CGFloat avatarH = 30;
    _avatarViewF = (CGRect){avatarX, avatarY, avatarW, avatarH};
    
    NSString *fromNickNameString = self.firstCommentM.member.name;
    if ([fromNickNameString isEqualToString:@""] || fromNickNameString == nil) {
        fromNickNameString = self.firstCommentM.member.mobile;
        if ([fromNickNameString isEqualToString:@""] || fromNickNameString == nil) {
            fromNickNameString = @"网友保保";
        }
    }
    CGSize fromNickNameSize = [fromNickNameString sizeWithFont:[UIFont fontNamePingFangMediumWithFloat:13] maxW:200];
    
    // 2.主动回复人昵称
    CGFloat fromNickNameX = CGRectGetMaxX(_avatarViewF) + 8;
    CGFloat fromNickNameY = avatarY;
    CGFloat fromNickNameW = fromNickNameSize.width;
    CGFloat fromNickNameH = 30;
    _fromNickNameViewF = (CGRect){fromNickNameX, fromNickNameY, fromNickNameW, fromNickNameH};
    
    CGFloat tousuerX = CGRectGetMaxX(_fromNickNameViewF);
    CGFloat tousuerY = avatarY;
    CGFloat tousuerW = 48;
    CGFloat tousuerH = fromNickNameH;
    if (self.firstCommentM.member.is_tousuer) {
        _isTousuPersonViewF = (CGRect){tousuerX, tousuerY, tousuerW, tousuerH};
    } else {
        tousuerW = 0;
        _isTousuPersonViewF = (CGRect){tousuerX, tousuerY, tousuerW, tousuerH};
    }
    
    // 4.评论内容
    NSString *commentContentString = self.firstCommentM.content;
    CGFloat commentContentX = fromNickNameX;
    CGFloat commentContentY = CGRectGetMaxY(_fromNickNameViewF) + 4;
    CGFloat commentContentW = ScreenWidth-commentContentX-self.margeX;
    CGSize commentContentSize = [commentContentString sizeWithFont:[UIFont fontNamePingFangRegularWithFloat:14] maxW:commentContentW];
    CGFloat commentContentH = commentContentSize.height;
    _commentContentViewF = (CGRect){commentContentX, commentContentY, commentContentW, commentContentH};
    
    // 5.评论时间
    CGFloat commentTimeX = fromNickNameX;
    CGFloat commentTimeY = CGRectGetMaxY(_commentContentViewF) + 12;
    CGFloat commentTimeW = 150;
    CGFloat commentTimeH = 12;
    _commentTimeViewF = (CGRect){commentTimeX, commentTimeY, commentTimeW, commentTimeH};
    
    // 6.回复按钮
    CGFloat replyButtonX = ScreenWidth-self.margeX-30+6;
    CGFloat replyButtonY = CGRectGetMaxY(_commentContentViewF);
    CGFloat replyButtonW = 30;
    CGFloat replyButtonH = 34;
    _replyButtonViewF = (CGRect){replyButtonX, replyButtonY, replyButtonW, replyButtonH};
    
    // 4.点赞按钮
    CGFloat praiseButtonX = replyButtonX - 50;
    CGFloat praiseButtonY = CGRectGetMaxY(_commentContentViewF)+2;
    CGFloat praiseButtonW = 50;
    CGFloat praiseButtonH = 30;
    _praiseViewF = (CGRect){praiseButtonX, praiseButtonY, praiseButtonW, praiseButtonH};
    
    // 7.二级tableView的高度
    CGFloat secondTableViewX = 0;
    CGFloat secondTableViewY = CGRectGetMaxY(_replyButtonViewF)+3;
    CGFloat secondTableViewW = ScreenWidth;
    
    // 计算二级评论cell的总高度
    CGFloat secondTableViewHeight = 0;
    
    if (self.firstCommentM.child.count) {
        self.replyCount = self.firstCommentM.comment_num;
        NSArray *secondCommentArray = self.firstCommentM.child;
        NSInteger secondCommentCount = self.firstCommentM.comment_num;
        if (secondCommentCount > 2) {
            self.childArray = @[].mutableCopy;
            NSArray *secondArray = [secondCommentArray subarrayWithRange:NSMakeRange(0, 2)];
            for (SecondCommentModel *childModel in secondArray) {
                ComplaintSecondCommentFrame *secondCommentFrame = [[ComplaintSecondCommentFrame alloc] initWithComplaintSecondCommentList:childModel];
                secondTableViewHeight += secondCommentFrame.secondCellHeight;
                [self.childArray addObject:secondCommentFrame];
            }
            // 37这个是tableFooterView
            _secondTableViewF = (CGRect){secondTableViewX, secondTableViewY, secondTableViewW, secondTableViewHeight + 37};
        } else {
            self.childArray = @[].mutableCopy;
            for (SecondCommentModel *childModel in secondCommentArray) {
                ComplaintSecondCommentFrame *secondCommentFrame = [[ComplaintSecondCommentFrame alloc] initWithComplaintSecondCommentList:childModel];
                secondTableViewHeight += secondCommentFrame.secondCellHeight;
                [self.childArray addObject:secondCommentFrame];
            }
            _secondTableViewF = (CGRect){secondTableViewX, secondTableViewY, secondTableViewW, secondTableViewHeight};
        }
    } else {
        _secondTableViewF = (CGRect){secondTableViewX, secondTableViewY, secondTableViewW, 0};
    }
    // 8.全部评论Cell的高度
    _cellHeight = CGRectGetMaxY(_secondTableViewF);
}

@end


@implementation ComplaintSecondCommentFrame

- (instancetype)initWithComplaintSecondCommentList:(SecondCommentModel *)secondCommentM {
    self = [super init];
    if (self) {
        self.secondCommentM = secondCommentM;
        [self setupLayouts];
    }
    return self;
}

- (void)setupLayouts {
    self.margeX = 15;
    self.margeY = 15;
    
    CGFloat upLineViewX = 53;
    CGFloat upLineViewY = 0;
    CGFloat upLineViewW = ScreenWidth-upLineViewX;
    CGFloat upLineViewH = 0.5;
    _upLineViewF = (CGRect){upLineViewX, upLineViewY, upLineViewW, upLineViewH};
    
    // 1.二级评论（一定会有toMember 和 member）
    NSString *fromNickNameString = self.secondCommentM.member.name;
    NSString *toNickNameString = self.secondCommentM.parent_member.name;
    if ([fromNickNameString isEqualToString:@""] || fromNickNameString == nil) {
        fromNickNameString = self.secondCommentM.member.mobile;
        if ([fromNickNameString isEqualToString:@""] || fromNickNameString == nil) {
            fromNickNameString = @"网友保保";
        }
    }
    if ([toNickNameString isEqualToString:@""] || toNickNameString == nil) {
        toNickNameString = self.secondCommentM.parent_member.mobile;
        if ([toNickNameString isEqualToString:@""] || toNickNameString == nil) {
            toNickNameString = @"网友保保";
        }
    }
    
    CGSize fromNickNameSize = [fromNickNameString sizeWithFont:[UIFont fontNamePingFangMediumWithFloat:13] maxW:200];
    CGSize toNickNameSize = [toNickNameString sizeWithFont:[UIFont fontNamePingFangMediumWithFloat:13] maxW:200];
        
    // 1.主动回复人昵称
    CGFloat fromNickNameX = 53;
    CGFloat fromNickNameY = self.margeY;
    CGFloat fromNickNameW = fromNickNameSize.width;
    CGFloat fromNickNameH = 30;
    _fromNickNameViewF = (CGRect){fromNickNameX, fromNickNameY, fromNickNameW, fromNickNameH};
    
    CGFloat fromTousuerX = CGRectGetMaxX(_fromNickNameViewF);
    CGFloat fromTousuerY = self.margeY;
    CGFloat fromTousuerW = 48;
    CGFloat fromTousuerH = fromNickNameH;
    // 投诉人
    if (self.secondCommentM.member.is_tousuer) {
        _fromNickNameTousuerF = (CGRect){fromTousuerX, fromTousuerY, fromTousuerW, fromTousuerH};
    } else {
        fromTousuerW = 0;
        _fromNickNameTousuerF = (CGRect){fromTousuerX, fromTousuerY, fromTousuerW, fromTousuerH};
    }
    
    // 2.中间箭头View 【回复】
    CGFloat middleViewX = CGRectGetMaxX(_fromNickNameTousuerF);
    CGFloat middleViewY = self.margeY;
    CGFloat middleViewW = 38;
    CGFloat middleViewH = 30;
    _middleViewF = (CGRect){middleViewX, middleViewY, middleViewW, middleViewH};
    
    // 3.被回复人昵称
    CGFloat toNickNameX = CGRectGetMaxX(_middleViewF);
    CGFloat toNickNameY = self.margeY;
    CGFloat toNickNameW = toNickNameSize.width;
    CGFloat toNickNameH = 30;
    _toNickNameViewF = (CGRect){toNickNameX, toNickNameY, toNickNameW, toNickNameH};
    
    CGFloat toTousuerX = CGRectGetMaxX(_toNickNameViewF);
    CGFloat toTousuerY = self.margeY;
    CGFloat toTousuerW = 48;
    CGFloat toTousuerH = fromNickNameH;
    // to投诉人
    if (self.secondCommentM.parent_member.is_tousuer) {
        _toNickNameTousuerF = (CGRect){toTousuerX, toTousuerY, toTousuerW, toTousuerH};
    } else {
        toTousuerW = 0;
        _toNickNameTousuerF = (CGRect){toTousuerX, toTousuerY, toTousuerW, toTousuerH};
    }
 
    // 5.评论内容
    NSString *commentContentString = self.secondCommentM.content;
    CGFloat commentContentX = fromNickNameX;
    CGFloat commentContentY = CGRectGetMaxY(_fromNickNameViewF) + 4;
    CGFloat commentContentW = ScreenWidth-commentContentX-self.margeX;
    CGSize commentContentSize = [commentContentString sizeWithFont:[UIFont fontNamePingFangRegularWithFloat:14] maxW:commentContentW];
    CGFloat commentContentH = commentContentSize.height;
    _commentContentViewF = (CGRect){commentContentX, commentContentY, commentContentW, commentContentH};
    
    // 6.评论时间
    CGFloat commentTimeX = fromNickNameX;
    CGFloat commentTimeY = CGRectGetMaxY(_commentContentViewF) + 12;
    CGFloat commentTimeW = 150;
    CGFloat commentTimeH = 12;
    _commentTimeViewF = (CGRect){commentTimeX, commentTimeY, commentTimeW, commentTimeH};
    
    // 7.回复按钮
    CGFloat replyButtonX = ScreenWidth-self.margeX-30+6;
    CGFloat replyButtonY = CGRectGetMaxY(_commentContentViewF);
    CGFloat replyButtonW = 30;
    CGFloat replyButtonH = 34;
    _replyButtonViewF = (CGRect){replyButtonX, replyButtonY, replyButtonW, replyButtonH};
    
     // 4.点赞按钮
     CGFloat praiseButtonX = replyButtonX - 50;
     CGFloat praiseButtonY = CGRectGetMaxY(_commentContentViewF)+2;
     CGFloat praiseButtonW = 50;
     CGFloat praiseButtonH = 30;
     _praiseViewF = (CGRect){praiseButtonX, praiseButtonY, praiseButtonW, praiseButtonH};
     
    
    // 8.热门评论Cell的高度
    _secondCellHeight = CGRectGetMaxY(_replyButtonViewF) + 3;
}

@end
