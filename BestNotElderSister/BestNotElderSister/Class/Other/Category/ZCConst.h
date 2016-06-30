#import <UIKit/UIKit.h>


typedef enum {
    ZCTopicTypeAll = 1,
    ZCTopicTypePicture = 10,
    ZCTopicTypeWord = 29,
    ZCTopicTypeVoice = 31,
    ZCTopicTypeVideo = 41
} ZCTopicType;


/** 精华-顶部标题的高度 */
UIKIT_EXTERN CGFloat const ZCTitilesViewHeight;
/** 精华-顶部标题的Y */
UIKIT_EXTERN CGFloat const ZCTitilesViewY;

/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const ZCTopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const ZCTopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const ZCTopicCellBottomBarHeight;