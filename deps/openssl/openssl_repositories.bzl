"""A module defining the third party dependency OpenSSL"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def openssl_repositories():
    maybe(
        http_archive,
        name = "openssl",
        build_file = Label("//deps/openssl:BUILD.openssl.bazel"),
        sha256 = "0f745b85519aab2ce444a3dcada93311ba926aea2899596d01e7f948dbd99981",
        strip_prefix = "openssl-OpenSSL_1_1_1o",
        urls = [
            "https://mirror.bazel.build/www.openssl.org/source/openssl-1.1.1o.tar.gz",
            "https://www.openssl.org/source/openssl-1.1.1o.tar.gz",
            "https://github.com/openssl/openssl/archive/OpenSSL_1_1_1o.tar.gz",
        ],
    )

    maybe(
        http_archive,
        name = "nasm",
        build_file = Label("//deps/openssl:BUILD.nasm.bazel"),
        sha256 = "f5c93c146f52b4f1664fa3ce6579f961a910e869ab0dae431bd871bdd2584ef2",
        strip_prefix = "nasm-2.15.05",
        urls = [
            "https://mirror.bazel.build/www.nasm.us/pub/nasm/releasebuilds/2.15.05/win64/nasm-2.15.05-win64.zip",
            "https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/win64/nasm-2.15.05-win64.zip",
        ],
    )

    maybe(
        http_archive,
        name = "rules_perl",
        sha256 = "765e6a282cc38b197a6408c625bd3fc28f3f2d44353fb4615490a6eb0b8f420c",
        strip_prefix = "rules_perl-e3ed0f1727d15db6c5ff84f64454b9a4926cc591",
        urls = [
            "https://github.com/bazelbuild/rules_perl/archive/e3ed0f1727d15db6c5ff84f64454b9a4926cc591.tar.gz",
        ],
    )
