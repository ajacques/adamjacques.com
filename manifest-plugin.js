var fs = require("fs");
var fse = require("fs-extra");
const crypto = require("crypto");

var DEFAULT_PARAMS = {
    manifestFile: "/rails-app/config/sprockets-manifest.json",
    statsFile: "webpack-stats.json"
};

function processFile(outputPath, sprockets, logicalPath, chunkFilename) {
    var chunkPath = outputPath + "/" + chunkFilename;
    var stat = fs.statSync(chunkPath);
    const fileBuffer = fs.readFileSync(chunkPath);
    const hashSum = crypto.createHash('sha256');
    hashSum.update(fileBuffer);
    const hash = hashSum.digest('base64');
    const hexHash = Buffer.from(hash, 'base64').toString('hex');

    sprockets.files[chunkFilename] = {
        "logical_path": logicalPath,
        "mtime": stat.mtime.toISOString(),
        "size": stat.size,
        "digest": hexHash,
        "integrity": "sha256-" + hash
    };
    sprockets.assets[logicalPath] = chunkFilename;
}

class WebpackSprocketsRailsManifestPlugin {
    constructor(options) {
        var params = options || {};

        this._manifestFile = params.manifestFile || DEFAULT_PARAMS.manifestFile;
        this._statsFile = params.statsFile || DEFAULT_PARAMS.statsFile;
    }
    apply(compiler) {
        var manifestFile = this._manifestFile;
        var statsFile = this._statsFile;
        var sprockets = {
            files: {},
            assets: {}
        };

        compiler.hooks.afterDone.tap("WebpackSprocketsRailsManifestPlugin", function (stats) {
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

            chunks.forEach(function (chunk) {
                const logicalName = chunk.names[0];
                chunk.files.forEach(filename => {
                    const chunkExtension = filename.split(".").pop();
                    processFile(outputPath, sprockets, `${logicalName}.${chunkExtension}`, filename);
                });
                chunk.auxiliaryFiles
                    .filter(name => !name.endsWith('.map'))
                    .forEach(filename => {
                        const nameParts = filename.split(".");
                        processFile(outputPath, sprockets, `${nameParts[0]}.${nameParts[2]}`, filename);
                    });
            });

            fse.mkdirpSync(outputPath);

            // delete files matching glob pattern
            let regex = /\.sprockets-manifest-.*\.json$/;
            fs.readdirSync(outputPath)
                .filter(f => regex.test(f))
                .map(f => fs.unlinkSync(outputPath + "/" + f));
            fse.outputFileSync(manifestPath, JSON.stringify(sprockets, null, "  "));
        });
    }
}

module.exports = WebpackSprocketsRailsManifestPlugin;
