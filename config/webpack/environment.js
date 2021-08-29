const { environment } = require('@rails/webpacker');

environment.loaders.delete('file')
environment.loaders.append('file', {
    test: /\.(jpg|jpeg|png|gif|tiff|ico|svg|eot|otf|ttf|woff|woff2|webm|mp4)$/i,
    use: [
        {
            loader: 'file-loader',
            options: {
                name: '[name].[contenthash].[ext]'
            }
        }
    ]
});

module.exports = environment;
