#!/usr/bin/env bash
set -e

# Memcache
# Compatible chart: https://github.com/websupport-sk/pecl-memcache
# Versions: https://pecl.php.net/package/memcache
declare -A MemcacheVersions=(
  [5.3]=2.2.7
  [5.4]=2.2.7
  [5.5]=2.2.7
  [5.6]=2.2.7
  [7.0]=4.0.5.2
  [7.1]=4.0.5.2
  [7.2]=4.0.5.2
  [7.3]=4.0.5.2
  [7.4]=4.0.5.2
  [8.0]=8.0
  [8.1]=8.0
)

# Memcached
# Compatible chart: https://github.com/php-memcached-dev/php-memcached
# Versions: https://pecl.php.net/package/memcached
declare -A MemcachedVersions=(
  [5.3]=2.2.0
  [5.4]=2.2.0
  [5.5]=2.2.0
  [5.6]=2.2.0
  [7.0]=3.1.5
  [7.1]=3.1.5
  [7.2]=3.1.5
  [7.3]=3.1.5
  [7.4]=3.1.5
  [8.0]=3.2.0
  [8.1]=3.2.0
)

# uploadprogress
# Compatible chart: https://pecl.php.net/package-changelog.php?package=uploadprogress
# Versions: https://pecl.php.net/package/uploadprogress
declare -A UploadProgressVersions=(
  [5.3]=1.1.4
  [5.4]=1.1.4
  [5.5]=1.1.4
  [5.6]=1.1.4
  [7.0]=1.1.4
  [7.1]=1.1.4
  [7.2]=2.0.2
  [7.3]=2.0.2
  [7.4]=2.0.2
  [8.0]=2.0.2
  [8.1]=2.0.2
)

# Xdebug
# Compatible chart: https://xdebug.org/docs/compat
# Versions: https://pecl.php.net/package/xdebug
declare -A XdebugVersions=(
  [5.3]=2.2.7
  [5.4]=2.4.1
  [5.5]=2.5.5
  [5.6]=2.5.5
  [7.0]=2.7.2
  [7.1]=2.9.6
  [7.2]=2.9.6
  [7.3]=2.9.6
  [7.4]=2.9.6
  [8.0]=3.1.5
  [8.1]=3.1.5
)

# Composer
# Compatible chart: https://getcomposer.org/doc/00-intro.md#system-requirements
## Composer in its latest version requires PHP 7.2.5 to run.
## A long-term-support version (2.2.x) still offers support for PHP 5.3.2+
## in case you are stuck with a legacy PHP version.
# Versions: https://getcomposer.org/download/
declare -A ComposerVersions=(
  [5.3]=2.2.18
  [5.4]=2.2.18
  [5.5]=2.2.18
  [5.6]=2.2.18
  [7.0]=2.2.18
  [7.1]=2.2.18
  [7.2]=2.4.3
  [7.3]=2.4.3
  [7.4]=2.4.3
  [8.0]=2.4.3
  [8.1]=2.4.3
)

cd versions
versions=( "$@" )
if [ ${#versions[@]} -eq 0 ]; then
    versions=( */ )
fi
versions=( "${versions[@]%/}" )
cd ..

for version in "${versions[@]}"; do
    echo "Updating $version"
    (
      rm -rf versions/$version
      mkdir -p versions/$version
      cp -ar README.md template/* versions/$version/
      sed -i -e 's/{{ version }}/'$version'/g' versions/$version/Dockerfile
    )


done
