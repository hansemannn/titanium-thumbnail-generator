/**
 * titanium-thumbnail-generator
 *
 * Created by Your Name
 * Copyright (c) 2019 Your Company. All rights reserved.
 */

#import <QuickLookThumbnailing/QuickLookThumbnailing.h>

#import "TiThumbnailModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiBlob.h"

@implementation TiThumbnailModule

#pragma mark Internal

- (id)moduleGUID
{
  return @"df746969-905f-4880-9d48-88bc2e5bf9de";
}

- (NSString *)moduleId
{
  return @"ti.thumbnail";
}

- (void)generateThumbnail:(id)params
{
  ENSURE_SINGLE_ARG(params, NSDictionary);
  
  NSURL *fileURL = [TiUtils toURL:params[@"url"] proxy:self];
  CGSize size = CGSizeMake([TiUtils floatValue:params[@"size"][@"width"]], [TiUtils floatValue:params[@"size"][@"height"]]);
  KrollCallback *callback = (KrollCallback *)params[@"callback"];

  QLThumbnailRepresentationType representationTypes = QLThumbnailRepresentationTypeThumbnail | QLThumbnailRepresentationTypeLowQualityThumbnail;

  QLThumbnailGenerationRequest *request = [[QLThumbnailGenerationRequest alloc] initWithFileAtURL:fileURL
                                                                                             size:size
                                                                                            scale:UIScreen.mainScreen.scale
                                                                              representationTypes:representationTypes];

  [[QLThumbnailGenerator sharedGenerator] generateBestRepresentationForRequest:request
                                                             completionHandler:^(QLThumbnailRepresentation * _Nullable thumbnail, NSError * _Nullable error) {
    if (error != nil) {
      [callback call:@[@{ @"success": @(NO), @"error": error.localizedDescription }] thisObject:self];
      return;
    }

    QLThumbnailRepresentationType representationType = thumbnail.type;
    UIImage *thumbnailImage = thumbnail.UIImage;

    [callback call:@[@{ @"success": @(YES), @"type": @(representationType), @"image": [[TiBlob alloc] initWithImage:thumbnailImage] }] thisObject:self];
  }];
}

MAKE_SYSTEM_PROP(THUMBNAIL_REPRESENTATION_TYPE_ICON, QLThumbnailRepresentationTypeIcon);
MAKE_SYSTEM_PROP(THUMBNAIL_REPRESENTATION_TYPE_LOW_QUALITY_THUMBNAIL, QLThumbnailRepresentationTypeLowQualityThumbnail);
MAKE_SYSTEM_PROP(THUMBNAIL_REPRESENTATION_TYPE_THUMBNAIL, QLThumbnailRepresentationTypeThumbnail);

@end
