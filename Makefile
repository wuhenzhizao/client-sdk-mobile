build_date = `date +%Y%m%d%H%M`
commit = `git rev-parse HEAD`
version = `git rev-parse --short HEAD`

.PHONY: release
clean:
	cargo clean
build_android:
	cargo install --version 0.18.0  uniffi_bindgen
	rustup target add armv7-linux-androideabi
	rustup target add aarch64-apple-darwin
	rustup target add i686-linux-android
	rustup target add x86_64-linux-android
	rustup target add aarch64-linux-android
	cd sdk-android && ./gradlew build
build_ios:
	cargo install --version 0.18.0  uniffi_bindgen
	rustup target add aarch64-apple-ios
	rustup target add aarch64-apple-ios-sim
	rustup target add x86_64-apple-ios
	cd sdk-ios && ./build-xcframework.sh

build:
	make build_android
	make build_ios

test:
	cargo test --verbose


