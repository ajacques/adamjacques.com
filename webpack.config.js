const path    = require("path");
const webpack = require("webpack");

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
    filename: "[name].js",
    sourceMapFilename: "[file].map",
    path: path.resolve(__dirname, "app/assets/builds"),
  },
  plugins: [
    new webpack.optimize.LimitChunkCountPlugin({
      maxChunks: 1
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
}