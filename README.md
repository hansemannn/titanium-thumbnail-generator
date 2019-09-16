# Titanium Thumbnail Generator

Generate thumbnails for common file types natively in Appcelerator Titanium.

> Note: Currently this module only supports iOS 13+ thumbnails using the `QuickLook` framework.

## Requirements

- [x] Titanium SDK 8.2.0+
- [x] iOS 13+

## Example

```js
ThumbnailGenerator.generateThumbnail({
    url: 'test.pdf',
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
