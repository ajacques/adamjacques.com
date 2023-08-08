const path    = require("path");
const webpack = require("webpack");
const WebpackSprocketsRailsManifestPlugin = require("./manifest-plugin");
const crypto = require("crypto");
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

const mode = process.env.RAILS_ENV === 'development' ? 'development' : 'production';

module.exports = {
  devtool: "source-map",
  entry: {
    application: "./app/javascript/packs/application.ts"
  },
  mode: mode,
  module: {
    rules: [
      {
        test: /\.(ts|tsx)?(\.erb)?$/,
        use: [{
          loader: 'ts-loader'
        }]
      },
      {
        test: /\.s?(css)$/,
        use: [MiniCssExtractPlugin.loader, 'css-loader', 'sass-loader']
      },
      {
        test: /\.(jpg|jpeg|png|gif|tiff|ico|svg|eot|otf|ttf|woff|woff2|webm|mp4)$/i,
        use: [
          {
            loader: 'file-loader',
            options: {
              name: '[name].[contenthash].[ext]'
            }
          }
        ]
      }
    ]
  },
  output: {
    filename: "[name]-[contenthash].js",
    sourceMapFilename: "[file].map",
    path: path.resolve(__dirname, "public/assets"),
  },
  plugins: [
    new webpack.optimize.LimitChunkCountPlugin({
      maxChunks: 1
    }),
    new MiniCssExtractPlugin({
      filename: "[name]-[contenthash].css"
    }),
    new WebpackSprocketsRailsManifestPlugin({
      manifestFile: `.sprockets-manifest-${crypto.randomBytes(8).toString("hex")}.json`
    })
  ],
  resolve: {
    extensions: [".ts", ".js"]
  }
}

if (mode === "development") {
  module.exports.optimization = {
    moduleIds: 'deterministic'
  };
} else {
  module.exports.optimization = {
    usedExports: true
  }
}