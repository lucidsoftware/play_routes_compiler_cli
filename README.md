# play_routes_compiler_cli
Command line interface to the Play Routes Compiler

[![Build Status](https://github.com/lucidsoftware/play_routes_compiler_cli/workflows/CI/badge.svg)](https://github.com/lucidsoftware/play_routes_compiler_cli/actions)

To release a new version to Maven Central:
 1. Push a tag with this syntax: `S1.S2--P1.P2.P3` where `S1.S2` is the Scala version and `P1.P2.P3` is the Play version. (e.g. `2.13--2.7.3`)
 2. Once the build completes (including the publish step), find the [staging repo in Sonatype](https://oss.sonatype.org/#stagingRepositories) (assuming you're signed in and have access to the project)
 3. Verify all the artifacts are on the staging Repository, and then close it through the Sonatype GUI
 4. Once Sonatype's pre-release checks on the repository complete, release it through the Sonatype GUI
 5. Verify the artifact's present in [Maven Central](https://search.maven.org/search?q=com.lucidchart) (it can take multiple hours for everything to sync)
 