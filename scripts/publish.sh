#! /bin/bash
##
## Build and deploy the play routes compiler jar

# artifactId="$(printenv COMPILER_CLI_ARTIFACT_ID)"
# version="$(printenv COMPILER_CLI_VERSION)"
# if [ -z "$artifactId" ] || [ -z "$version" ]; then
#   echo "Either the artifactId or the version is not defined. Aborting publish to Maven."
#   exit 1
# fi

artifactId="play-routes-compiler-cli_2.11"
version="test-deploy-0.1"

# Maven requires a source jar and a javadoc jar to be included, but this is a Scala project
mkdir -p temp
echo "empty jar" > temp/README
source_jar="temp/$artifactId-$version-sources.jar"
javadoc_jar="temp/$artifactId-$version-javadoc.jar"
jar -cf "$source_jar" temp/README
jar -cf "$javadoc_jar" temp/README

# Determine the url to publish to based on whether this is a SNAPSHOT version
is_snapshot=$(echo "$version" | grep -o "SNAPSHOT" | wc -w)
if [[ $is_snapshot > 0 ]]; then
	url="https://oss.sonatype.org/content/repositories/snapshots"
else
	url="https://oss.sonatype.org/service/local/staging/deploy/maven2"
fi

# Build everything
#bazel clean --expunge
bazel build play-routes-compiler:play-routes-compiler_deploy.jar
bazel build play-routes-compiler:pom

deploy_jar="bazel-bin/play-routes-compiler/play-routes-compiler_deploy.jar"
pom_file="bazel-bin/play-routes-compiler/pom.xml"

# source_jar="to_deploy/play-routes-compiler-cli_2.12-2.7.2-sources.jar"
# javadoc_jar="to_deploy/play-routes-compiler-cli_2.12-2.7.2-javadoc.jar"

# deploy_jar="to_deploy/play-routes-compiler_deploy.jar"
# pom_file="to_deploy/pom.xml"
# url="https://oss.sonatype.org/service/local/staging/deploy/maven2"

# Create signatures
gpg -ab "$deploy_jar"
gpg -ab "$pom_file"
gpg -ab "$javadoc_jar"
gpg -ab "$source_jar"

echo "Deploying to Maven"
mvn deploy:deploy-file \
	-Dfile="$deploy_jar" \
	-Dfiles="$javadoc_jar.asc","$source_jar.asc","$deploy_jar.asc","$pom_file.asc" \
	-Dtypes=jar.asc,jar.asc,jar.asc,pom.asc \
	-Dclassifiers=javadoc,sources,, \
	-DpomFile="$pom_file" \
	-DrepositoryId="oss-sonatype-org" \
	-Durl="$url" \
	-Djavadoc="$javadoc_jar" \
	-Dsources="$source_jar" \
	--settings=".mvn_settings.travis.xml" \

echo "Deployment complete."
