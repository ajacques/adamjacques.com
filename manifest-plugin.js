var fs = require("fs");
var fse = require("fs-extra");

var DEFAULT_PARAMS = {
    manifestFile: "/rails-app/config/sprockets-manifest.json",
    statsFile: "webpack-stats.json"
};

function WebpackSprocketsRailsManifestPlugin(options) {
    var params = options || {};

    this._manifestFile = params.manifestFile || DEFAULT_PARAMS.manifestFile;
    this._statsFile = params.statsFile || DEFAULT_PARAMS.statsFile;
}

WebpackSprocketsRailsManifestPlugin.prototype.apply = function(compiler) {
    var manifestFile = this._manifestFile;
    var statsFile = this._statsFile;
    var sprockets = {
        files: {},
        assets: {}
    };

    compiler.hooks.done.tap("WebpackSprocketsRailsManifestPlugin", function(stats) {
        var statsJson = stats.toJson();
        var chunks = statsJson.chunks;
        var devServer = compiler.options.devServer;
        var outputPath;

        if (devServer && devServer.contentBase) {
            outputPath = devServer.contentBase;
        } else {
            outputPath = compiler.options.output.path;
        }

        var manifestPath = outputPath + "/" + manifestFile;

        chunks.forEach(function(chunk) {
            chunk.files.forEach(function (chunkFilename) {
                var chunkPath = outputPath + "/" + chunkFilename;
                var chunkExtension = chunkFilename.split(".").pop();
                var logicalPath = chunk.names[0] + "." + chunkExtension;
                var mtime;

                if (fs.existsSync(chunkPath)) {
                    mtime = fs.statSync(chunkPath).mtime;
                } else {
                    mtime = new Date();
                }

                sprockets.files[chunkFilename] = {
                    "logical_path": logicalPath,
                    "mtime": mtime.toISOString(),
                    "size": chunk.size,
                    "digest": chunk.hash,
                    // TODO
                    // "integrity": "sha256-Zk2O+Q1SFSuzslxNc6LuqFrAN5PlRHlbKeGzXfN4Xmc="
                };
                sprockets.assets[logicalPath] = chunkFilename;
            });
        });

        fse.mkdirpSync(outputPath);

        // delete files matching glob pattern
        let regex = /\.sprockets-manifest-.*\.json$/
        fs.readdirSync(outputPath)
            .filter(f => regex.test(f))
            .map(f => fs.unlinkSync(outputPath + "/" + f));
        fse.outputFileSync(manifestPath, JSON.stringify(sprockets, null, "  "));
    });
};

module.exports = WebpackSprocketsRailsManifestPlugin;
