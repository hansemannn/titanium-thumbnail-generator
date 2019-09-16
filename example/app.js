var ThumbnailGenerator = require('ti.thumbnail');

var win = Ti.UI.createWindow({
    backgroundColor: '#fff'
});

var btn = Ti.UI.createButton({
    title: 'Generate thumbnail',
    top: 100
});

var imageView = Ti.UI.createImageView({ top: 200, width: 300 });

btn.addEventListener('click', function () {
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
});

win.add([btn, imageView]);
win.open();
