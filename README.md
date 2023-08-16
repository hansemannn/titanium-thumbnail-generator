# Titanium Thumbnail Generator

Generate high performance thumbnails for common file types natively using the Titanium SDK.

Note: Android currently only supports PDF files. For other file types, 
please use the [ti.imagefactory](https://github.com/tidev/ti.imagefactory/) function [imageAsThumbnail](https://github.com/tidev/ti.imagefactory/#imageasthumbnailblob-options).

## Requirements

- [x] Titanium SDK 9.2.0+
- [x] iOS 13+ / Android 5.1+

## Example

```js
import ThumbnailGenerator from 'ti.thumbnail';

ThumbnailGenerator.generateThumbnail({
    url: '/local/path/to/my.pdf',
    size: { width: 600, height: 600 },
    callback: event => {
        if (!event.success) {
            alert(event.error);
            return;
        }

        imageView.image = event.image;
    }
});
```

## License

MIT

## Author

Hans Knöchel
