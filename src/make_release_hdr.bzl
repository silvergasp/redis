_RELEASE_TEMPLATE_SH = """
set -e -u -o pipefail

while read line; do
  export "${line% *}"="${line#* }"
done <"$INFO_FILE"

while read line; do
  export "${line% *}"="${line#* }"
done <"$VERSION_FILE"

echo -e "#define REDIS_GIT_SHA1 \\"$STABLE_GIT_SHA1\\"" > $OUTPUT
echo -e "#define REDIS_GIT_DIRTY \\"$GIT_DIRTY\\"" >> $OUTPUT
echo -e "#define REDIS_BUILD_ID \\"$BUILD_ID\\"" >> $OUTPUT
echo -e "#include \\"version.h\\"" >> $OUTPUT
echo -e "#define REDIS_BUILD_ID_RAW REDIS_VERSION REDIS_BUILD_ID REDIS_GIT_DIRTY REDIS_GIT_SHA1" >> $OUTPUT
"""

def _release_header_impl(ctx):
    header = ctx.actions.declare_file("release.h")
    ctx.actions.run_shell(
        outputs = [header],
        inputs = [ctx.info_file, ctx.version_file],
        progress_message = "Generating version file: " + ctx.label.name,
        command = _RELEASE_TEMPLATE_SH,
        env = {
            "INFO_FILE": ctx.info_file.path,
            "VERSION_FILE": ctx.version_file.path,
            "OUTPUT": header.path,
        },
    )
    return [DefaultInfo(files = depset([header]))]

_release_hdr = rule(
    implementation = _release_header_impl,
)

def make_release_hdr(name):
    _release_hdr(
        name = name + "_hdr",
    )

    native.cc_library(
        name = name,
        hdrs = [name + "_hdr"],
        includes = ["."],
    )
