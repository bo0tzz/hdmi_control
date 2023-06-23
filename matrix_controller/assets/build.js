const esbuild = require("esbuild")
const sveltePlugin = require("esbuild-svelte")
const importGlobPlugin = require("esbuild-plugin-import-glob").default
const sveltePreprocess = require("svelte-preprocess")

const args = process.argv.slice(2)
const watch = args.includes("--watch")
const deploy = args.includes("--deploy")

let optsClient = {
    entryPoints: ["js/app.js"],
    bundle: true,
    target: "es2017",
    conditions: ["svelte"],
    outdir: "../priv/static/assets",
    logLevel: "info",
    minify: deploy,
    sourcemap: watch ? "inline" : false,
    watch,
    tsconfig: "./tsconfig.json",
    plugins: [
        importGlobPlugin(),
        sveltePlugin({
            preprocess: sveltePreprocess(),
            compilerOptions: {hydratable: true, css: true},
        }),
    ],
}

const client = esbuild.build(optsClient)

if (watch) {
    client.then(_result => {
        process.stdin.on("close", () => process.exit(0))
        process.stdin.resume()
    })
}
