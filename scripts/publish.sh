#! /bin/bash
##
## Build and deploy the play routes compiler jar

# Build the deploy jar
bazel build play-routes-compiler:play-routes-compiler_deploy.jar

# Generate pom.xml
bazel build play-routes-compiler:pom

deploy_jar="bazel-out/k8-fastbuild/bin/play-routes-compiler/play-routes-compiler_deploy.jar"
pom_file="bazel-out/k8-fastbuild/bin/play-routes-compiler/pom.xml"

artifactId="play-routes-compiler-cli"
version=$(cat play-routes-compiler/BUILD.bazel | egrep "^version" | awk -F '"' '{print $2}')
source_jar="temp/$artifactId-$version-sources.jar"
javadoc_jar="temp/$artifactId-$version-javadoc.jar"

# Maven requires a source jar and a javadoc jar to be included, but this is a Scala project
mkdir -p temp
echo "empty jar" > temp/README
jar -cf "$source_jar" temp/README
jar -cf "$javadoc_jar" temp/README

# There might be a better way to do this
is_snapshot=$(echo "$version" | grep -o "SNAPSHOT" | wc -w)
if [[ $is_snapshot > 0 ]]; then
	url="https://oss.sonatype.org/content/repositories/snapshots"
else
	url="https://oss.sonatype.org/service/local/staging/deploy/maven2"
fi

# Deploy to maven
echo "Deploying $deploy_jar to $url"
mvn -e --fail-at-end gpg:sign-and-deploy-file \
	-Dfile="$deploy_jar" \
	-DpomFile="$pom_file" \
	-DrepositoryId="oss-sonatype-org" \
	-Durl="$url" \
  -Djavadoc="$javadoc_jar" \
  -Dsources="$source_jar" \
	--settings=".mvn_settings.travis.xml"

echo "Deployment complete."
