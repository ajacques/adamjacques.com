const path    = require("path");
const webpack = require("webpack");
const WebpackSprocketsRailsManifestPlugin = require("./manifest-plugin");
const crypto = require("crypto");
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const fs = require("fs");

const mode = process.env.RAILS_ENV === 'development' ? 'development' : 'production';

const ref = fs.readFileSync('.git/HEAD').toString().trim();
let commit;
if (ref.startsWith('ref: '))
{
  commit = fs.readFileSync(ref.replace('ref: ', '.git/')).toString().trim();
} else {
  commit = ref;
}

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
    filename: mode === "development" ? "[name].js" : "[name]-[contenthash].js",
    sourceMapFilename: "[file].map",
    path: path.resolve(__dirname, "public/assets"),
  },
  devServer: {
    compress: false,
    host: "0.0.0.0",
    port: 3000,
  },
  watchOptions: {
    poll: 1000,
  },
  plugins: [
    new webpack.EnvironmentPlugin({
      'process.env.SENTRY_RELEASE': `adamjacques-website@${commit.substring(0, 8)}`
    }),
    new webpack.optimize.LimitChunkCountPlugin({
      maxChunks: 1
    }),
    new MiniCssExtractPlugin({
      filename: mode === "development" ? "[name].css" : "[name]-[contenthash].css"
    }),
    new WebpackSprocketsRailsManifestPlugin({
      manifestFile: `.sprockets-manifest-${crypto.randomBytes(16).toString("hex")}.json`
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