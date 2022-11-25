//
//  ComplaintCommentFrame.h
//  xfb
//
//  Created by XFB on 2019/10/8.
//  Copyright © 2019 XFB. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@class ComplaintFirstComment;
@interface ComplaintCommentFrame : BaseModel

- (instancetype)initWithFirstComment:(ComplaintFirstComment *)firstCommentM;

@property (nonatomic, strong) ComplaintFirstComment *firstCommentM;
@property (nonatomic, assign) CGFloat margeX; //横向间距
@property (nonatomic, assign) CGFloat margeY; //纵向间距

@property (nonatomic, assign) CGRect topLineViewF;
@property (nonatomic, assign) CGRect avatarViewF;
@property (nonatomic, assign) CGRect fromNickNameViewF;

/**  投诉人标记View  */
@property (nonatomic, assign) CGRect isTousuPersonViewF;

/** 点赞 */
@property (nonatomic, assign) CGRect praiseViewF;
/** 评论内容 */
@property (nonatomic, assign) CGRect commentContentViewF;
/** 评论时间 */
@property (nonatomic, assign) CGRect commentTimeViewF;
/** 回复按钮 */
@property (nonatomic, assign) CGRect replyButtonViewF;

// 二级评论
@property (nonatomic, assign) CGRect secondTableViewF;
// 全部评论的高度
@property (nonatomic,assign) CGFloat cellHeight;
// 回复数组
@property (nonatomic, strong) NSMutableArray *childArray;
// 总的回复条数
@property (nonatomic, assign) NSInteger replyCount;

@end

NS_ASSUME_NONNULL_END

@class SecondCommentModel;
@interface ComplaintSecondCommentFrame : BaseModel

- (instancetype)initWithComplaintSecondCommentList:(SecondCommentModel *)secondCommentM;

@property (nonatomic, strong) SecondCommentModel *secondCommentM;

@property (nonatomic, assign) CGFloat margeX; //横向间距
@property (nonatomic, assign) CGFloat margeY; //纵向间距

@property (nonatomic, assign) CGRect upLineViewF;

// 是否是投诉人？
@property (nonatomic, assign) CGRect fromNickNameTousuerF;
@property (nonatomic, assign) CGRect fromNickNameViewF;

@property (nonatomic, assign) CGRect middleViewF;
@property (nonatomic, assign) CGRect toNickNameViewF;
// 是否是投诉人？
@property (nonatomic, assign) CGRect toNickNameTousuerF;

@property (nonatomic, assign) CGRect praiseViewF;
@property (nonatomic, assign) CGRect commentContentViewF;
@property (nonatomic, assign) CGRect commentTimeViewF;
@property (nonatomic, assign) CGRect replyButtonViewF;
@property (nonatomic, assign) CGFloat secondCellHeight;

@end
